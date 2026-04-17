-- nvim/lua/core/lsp.lua
-- nvim/lua/core/lsp.lua

-- Create a base configuration with File Watching enabled
local base_config = {
    capabilities = vim.lsp.protocol.make_client_capabilities()
}
-- Enable native file watching (available in Neovim 0.10+)
base_config.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- List of standard servers that don't need custom .lua files
local standard_servers = {
    "lua_ls", "clangd", "rust_analyzer", "pyright",
    "vtsls", "bashls", "html", "jsonls", "cssls"
}

-- 1. Register base configs for standard servers to stop the WARNINGS
for _, server in ipairs(standard_servers) do
    vim.lsp.config(server, base_config)
end

-- 2. Load custom configurations from your wanj_lsp folder
local function setup_custom(name, server_key)
    local ok, config = pcall(require, "wanj_lsp." .. name)
    if ok then
        -- Merge file watcher capability into your custom config
        config.capabilities = vim.tbl_deep_extend("force", base_config.capabilities, config.capabilities or {})
        vim.lsp.config(server_key, config)
    end
end

setup_custom("lua", "lua_ls")
setup_custom("cpp", "clangd")
setup_custom("rust", "rust_analyzer")
setup_custom("cmake_ls", "neocmake")
setup_custom("typescript", "vtsls")
setup_custom("python", "pyright")
setup_custom("kotlin", "kotlin_language_server")

-- 3. Now enable them all safely
vim.lsp.enable(standard_servers)
vim.lsp.enable({ "neocmake", "kotlin_language_server" })

-- 4. The LspAttach Autocmd (Fixed for nesting)
-- nvim/lua/core/lsp.lua

-- Create a base configuration with File Watching enabled
local base_config = {
    capabilities = vim.lsp.protocol.make_client_capabilities()
}
-- Enable native file watching (available in Neovim 0.10+)
base_config.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- List of standard servers that don't need custom .lua files
local standard_servers = {
    "lua_ls", "clangd", "rust_analyzer", "pyright",
    "vtsls", "bashls", "html", "jsonls", "cssls"
}

-- 1. Register base configs for standard servers to stop the WARNINGS
for _, server in ipairs(standard_servers) do
    vim.lsp.config(server, base_config)
end

-- 2. Load custom configurations from your wanj_lsp folder
local function setup_custom(name, server_key)
    local ok, config = pcall(require, "wanj_lsp." .. name)
    if ok then
        -- Merge file watcher capability into your custom config
        config.capabilities = vim.tbl_deep_extend("force", base_config.capabilities, config.capabilities or {})
        vim.lsp.config(server_key, config)
    end
end

setup_custom("cpp", "clangd")
setup_custom("cmake", "neocmakels")
setup_custom("java", "jdtls")
setup_custom("kotlin", "kotlin_language_server")

-- 3. Now enable them all safely
vim.lsp.enable(standard_servers)
vim.lsp.enable({ "neocmakels", "jdtls", "kotlin_language_server" })

-- 4. The LspAttach Autocmd (Fixed for nesting)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        local bufnr = ev.buf
        local opts = { buffer = bufnr }

        -- Enable completions
        if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- Inlay hints (great for your Kotlin/Java work)
        if client:supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end

        -- Keymaps
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        if client:supports_method("textDocument/signatureHelp") then
            vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
        end

        -- Enable semantic tokens for C++23 highlighting
        if client:supports_method("textDocument/semanticTokens/full") then
            vim.lsp.semantic_tokens.start(bufnr, client.id)
        end
    end,
})

-- Create a base configuration with File Watching enabled
local base_config = {
    capabilities = vim.lsp.protocol.make_client_capabilities()
}
-- Enable native file watching (available in Neovim 0.10+)
base_config.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- List of standard servers that don't need custom .lua files
local standard_servers = {
    "lua_ls", "clangd", "rust_analyzer", "pyright",
    "vtsls", "bashls", "html", "jsonls", "cssls"
}

-- 1. Register base configs for standard servers to stop the WARNINGS
for _, server in ipairs(standard_servers) do
    vim.lsp.config(server, base_config)
end

-- 2. Load custom configurations from your wanj_lsp folder
local function setup_custom(name, server_key)
    local ok, config = pcall(require, "wanj_lsp." .. name)
    if ok then
        -- Merge file watcher capability into your custom config
        config.capabilities = vim.tbl_deep_extend("force", base_config.capabilities, config.capabilities or {})
        vim.lsp.config(server_key, config)
    end
end

setup_custom("cpp", "clangd")
setup_custom("cmake", "neocmakels")
setup_custom("java", "jdtls")
setup_custom("kotlin", "kotlin_language_server")

-- 3. Now enable them all safely
vim.lsp.enable(standard_servers)
vim.lsp.enable({ "neocmakels", "jdtls", "kotlin_language_server" })

-- 4. The LspAttach Autocmd (Fixed for nesting)
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then return end

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Enable semantic highlighting for C++23
        if client:supports_method("textDocument/semanticTokens/full") then
            -- vim.lsp.semantic_tokens.start(ev.buf, client.id)
            vim.lsp.semantic_tokens.enable(true)
        end
    end,
})

-- Diagnostic styling
vim.diagnostic.config({
    virtual_text = { current_line = true },
    float = { border = "rounded" },
})
