-- lua/plugins/lualine.lua
return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = "kanagawa",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff" },
                    -- FIX: was lualine_d — not a valid section; diagnostics were silently ignored.
                    -- Valid sections: a, b, c, x, y, z. Diagnostics belong in lualine_c or lualine_x.
                    lualine_c = {
                        {
                            "diagnostics",
                            sources  = { "nvim_lsp", "nvim_diagnostic" },
                            -- FIX: removed "coc" — coc.nvim is not installed
                            sections = { "error", "warn", "info", "hint" },
                            diagnostics_color = {
                                error = "DiagnosticError",
                                warn  = "DiagnosticWarn",
                                info  = "DiagnosticInfo",
                                hint  = "DiagnosticHint",
                            },
                            symbols          = { error = "", warn = "", info = "", hint = "" },
                            colored          = true,
                            update_in_insert = false,  -- don't update in insert (performance)
                            always_visible   = false,  -- hide when no diagnostics
                        },
                        { "filename", path = 1 },      -- show relative path
                    },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
