-- lua/wanj_lsp/rust.lua
-- FIX: rust-analyzer settings MUST be nested under the "rust-analyzer" key.
-- The original flat structure was silently ignored by the server.
return {
    cmd       = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            cargo = {
                buildScripts = { enable = true },
            },
            inlayHints = {
                bindingModeHints       = { enable = true },
                chainingHints          = { enable = true },
                parameterHints         = { enable = true },
                typeHints              = { enable = true },
            },
        },
    },
}
