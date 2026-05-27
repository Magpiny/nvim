-- lua/config/treesitter.lua
-- WANJARE SAMUEL
-- Native Neovim 0.11 treesitter integration (no nvim-treesitter plugin required)
-- Automatically starts highlighting per buffer and installs missing parsers.

local function install_parser(lang)
    vim.system(
        { "tree-sitter", "fetch-sitter-parser", lang },
        { text = true },
        function(result)
            if result.code == 0 then
                vim.schedule(function()
                    vim.notify("Treesitter: installed parser for '" .. lang .. "'", vim.log.levels.INFO)
                end)
            end
        end
    )
end

local function enable_treesitter(buf)
    -- Guard: skip if highlighter is already active (prevents E218)
    if vim.treesitter.highlighter.active[buf] then
        return true
    end

    local ok = pcall(vim.treesitter.start, buf)
    if ok then
        -- Per-window fold settings (vim.wo[0] = current window)
        vim.wo[0].foldmethod = "expr"
        vim.wo[0].foldexpr   = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0].foldenable = false -- open all folds on start
    end
    return ok
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
    callback = function(ev)
        -- Skip special buffers (dashboard, terminal, prompt, etc.)
        if vim.bo[ev.buf].buftype ~= "" then return end

        local ft   = ev.match
        local lang = vim.treesitter.language.get_lang(ft) or ft

        local ok   = enable_treesitter(ev.buf)
        if not ok then
            install_parser(lang)
            -- Retry after parser download completes
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(ev.buf) then
                    enable_treesitter(ev.buf)
                end
            end, 3000)
        end
    end,
})
