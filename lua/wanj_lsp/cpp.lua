-- C++ tuning in neovim (clangd LSP config)

return {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--header-insertion-decorators=0",
        "--pch-storage=memory",
        "--fallback-style=LLVM",                        -- Fallback formatting style
        "--query-driver=/usr/bin/g++,/usr/bin/clang++", -- Allow clangd to query system drivers
    },
    filetypes = { "c", "cpp" },
    root_markers = {
        "compile_commands.json",
        ".clangd",
        ".clang-format",
        "CMakeLists.txt",
        ".git",
    },
    capabilities = {
        textDocument = {
            semanticTokens = {
                dynamicRegistration = true,
            },
            foldingRange = {
                dynamicRegistration = true,
                lineFoldingOnly = true,
            },
        },
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
    -- clangd does not honour compileFlags here; settings block is largely a no-op
    -- for clangd. Leave it minimal or remove it entirely.
    settings = {},
}
