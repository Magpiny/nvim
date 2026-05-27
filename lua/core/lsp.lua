-- lua/core/lsp.lua
-- WANJARE SAMUEL
-- Neovim 0.11+ native LSP — vim.lsp.config / vim.lsp.enable
--
-- FIX: The original file was copy-pasted THREE times, causing:
--   • `local base_config` declared 3x → Lua redefinition error
--   • LspAttach autocmd registered TWICE → duplicate keymaps on every attach
--   • vim.lsp.enable() called 3x
--   • setup_custom() calls inconsistent between copies
-- This is the single, clean version.

-- ── Capabilities ─────────────────────────────────────────────────────────────
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Native file watching (0.10+)
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- Fold capabilities for clangd
capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly     = true,
}

-- Merge nvim-cmp capabilities if available
-- FIX: removed vim.lsp.completion.enable() — conflicts with nvim-cmp
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
    capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
end

-- ── Standard servers (use nvim-lspconfig defaults, just apply capabilities) ──
local standard_servers = {
    "lua_ls", "clangd", "rust_analyzer", "pyright",
    "vtsls", "bashls", "html", "jsonls", "cssls",
    "awk_ls", "kotlin",
}

vim.lsp.config("*", { capabilities = capabilities })

-- ── Custom server configs from wanj_lsp/ ─────────────────────────────────────
local function load_custom(module_name, server_key)
    local ok, config = pcall(require, "wanj_lsp." .. module_name)
    if ok and type(config) == "table" then
        -- Capabilities are already set globally via vim.lsp.config("*", …)
        -- Only pass server-specific overrides here
        vim.lsp.config(server_key, config)
    end
end

load_custom("lua", "lua_ls")
load_custom("cpp", "clangd")
load_custom("rust", "rust_analyzer")
load_custom("cmake", "neocmakelsp") -- FIX: was "cmake_ls" (wrong module name)
load_custom("typescript", "vtsls")
load_custom("python", "pyright")
load_custom("bashls", "bashls")
load_custom("html", "html")
load_custom("cssls", "cssls")
load_custom("jinja_lsp", "jinja_lsp")
load_custom("djlsp", "djlsp")
load_custom("awk_ls", "awk_ls")

-- ── Enable all servers ────────────────────────────────────────────────────────
vim.lsp.enable(standard_servers)
vim.lsp.enable({ "neocmakelsp", "jinja_lsp", "djlsp" })

-- ── LspAttach: keymaps + features (registered ONCE) ──────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        local buf = ev.buf
        local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc, silent = true })
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
        map("n", "gD", vim.lsp.buf.declaration, "LSP: Declaration")
        map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
        map("n", "go", vim.lsp.buf.type_definition, "LSP: Type definition")
        map("n", "gr", vim.lsp.buf.references, "LSP: References")
        map("n", "K", vim.lsp.buf.hover, "LSP: Hover")

        -- Actions
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")

        if client:supports_method("textDocument/signatureHelp") then
            map("i", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature help")
        end

        -- Inlay hints toggle
        if client:supports_method("textDocument/inlayHint") then
            -- Enable by default; toggle with <leader>ih
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            map("n", "<leader>ih", function()
                local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
                vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
            end, "LSP: Toggle inlay hints")
        end

        -- Semantic tokens for C++ / Rust
        -- FIX: vim.lsp.semantic_tokens.enable(true) is WRONG API
        -- semantic_tokens.start() is the correct call; but in 0.11 it's
        -- started automatically when the server supports it. No manual call needed.
    end,
})

-- ── Diagnostics ──────────────────────────────────────────────────────────────
vim.diagnostic.config({
    virtual_text     = { current_line = true },
    signs            = true,
    underline        = true,
    update_in_insert = false,
    severity_sort    = true,
    float            = { border = "rounded", source = true },
})
