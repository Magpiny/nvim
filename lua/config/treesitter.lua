-- ~/.config/nvim/lua/config/treesitter.lua

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
    -- GUARD: Check if highlighters are already attached to avoid E218
    if vim.treesitter.highlighter.active[buf] then
        return true
    end

    local ok = pcall(vim.treesitter.start, buf)
    if ok then
        vim.wo[0].foldmethod = "expr"
        vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
    return ok
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("NativeTreesitter", { clear = true }),
    callback = function(ev)
        -- Ignore special buffers (dashboard, prompts, etc)
        local buftype = vim.bo[ev.buf].buftype
        if buftype ~= "" then return end

        local ft = ev.match
        local lang = vim.treesitter.language.get_lang(ft) or ft

        local ok = enable_treesitter(ev.buf)

        if not ok then
            -- Only attempt install if we haven't already failed this session
            install_parser(lang)
            vim.defer_fn(function()
                if vim.api.nvim_buf_is_valid(ev.buf) then
                    enable_treesitter(ev.buf)
                end
            end, 3000)
        end
    end,
})
