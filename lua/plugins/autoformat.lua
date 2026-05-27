-- lua/plugins/autoformat.lua
return {
    {
        "preservim/nerdcommenter",
    },

    {
        "stevearc/conform.nvim",
        lazy = false,
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        opts = {
            notify_on_error  = true,
            format_on_save   = function(bufnr)
                local disable_filetypes = { elixir = true, zig = true }
                return {
                    timeout_ms = 500,
                    -- FIX: lsp_fallback is deprecated → use lsp_format
                    lsp_format = not disable_filetypes[vim.bo[bufnr].filetype] and "fallback" or "never",
                }
            end,
            formatters_by_ft = {
                lua        = { "stylua" },
                html       = { "prettier" },
                css        = { "prettier" },
                cpp        = { "clang_format" },
                c          = { "clang_format" },
                rust       = { "rustfmt", lsp_format = "fallback" },
                python     = { "ruff_format", "autopep8", stop_after_first = true },
                -- FIX: was " prettierd " (spaces) → conform looks for exact name
                javascript = { "prettierd" },
                typescript = { "prettierd" },
            },
        },
    },
}
