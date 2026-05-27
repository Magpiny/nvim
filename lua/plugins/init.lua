-- lua/plugins/init.lua
-- Plugins that need no dedicated config file.

return {
    { "tpope/vim-repeat" },
    { "tpope/vim-fugitive" },
    { "stevearc/dressing.nvim",    opts = {} },
    { "folke/which-key.nvim",      opts = {} },
    { "folke/neoconf.nvim",        cmd  = "Neoconf" },
    { "preservim/tagbar" },

    -- FIX: folke/neodev.nvim is DEPRECATED (archived). Replaced by lazydev.nvim.
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },

    -- FIX: removed akinsho/bufferline.nvim — duplicate of barbar.nvim (barbar.lua).
    -- Two buffer-line plugins active simultaneously causes visual conflicts.
    -- barbar is fully configured in plugins/barbar.lua; bufferline is dead weight.

    {
        "folke/todo-comments.nvim",
        event        = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts         = { signs = true },
    },
}
