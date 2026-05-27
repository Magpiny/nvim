-- lua/plugins/colorscheme.lua
return {
    "rebelot/kanagawa.nvim",
    -- FIX: was lazy = true — but init.lua calls colorscheme at startup,
    -- so the plugin MUST be loaded eagerly. lazy=true caused a delayed load
    -- and defeated compile=true's cache. priority=1000 ensures it loads first.
    lazy     = false,
    priority = 1000,
    config   = function()
        require("kanagawa").setup({
            compile = true,  -- run :KanagawaCompile after config changes
        })
    end,
}
