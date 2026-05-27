-- lua/plugins/treesitter.lua
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "python", "lua", "c", "cpp", "rust",
            "bash", "vim", "vimdoc", "cmake",
            "html", "css", "javascript", "typescript",
            "json", "yaml", "toml", "markdown",
        },
        auto_install     = true,
        highlight        = { enable = true },
        indent           = { enable = true },
    },
}
