-- lua/wanj_lsp/html.lua
-- FIX: "html-languageserver" is the OLD binary name from vscode-langservers-extracted.
-- Current name is "vscode-html-language-server".
return {
    cmd          = { "vscode-html-language-server", "--stdio" },
    filetypes    = { "html" },
    root_markers = { "package.json", ".git" },
}
