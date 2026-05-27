-- lua/wanj_lsp/cssls.lua
-- FIX: "css-languageserver" is the OLD binary name.
-- Current name is "vscode-css-language-server".
return {
    cmd          = { "vscode-css-language-server", "--stdio" },
    filetypes    = { "css", "scss", "less" },
    root_markers = { "package.json", "node_modules" },
    settings     = {
        css  = { validate = true },
        less = { validate = true },
        scss = { validate = true },
    },
}
