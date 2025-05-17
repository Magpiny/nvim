return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			animation = true,
			tabpages = true,
			icons = {
				-- Configure the base icons on the bufferline.
				-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
				buffer_index = "superscript",
				buffer_number = true,
				button = "",
				-- Enables / disables diagnostic symbols
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "󱔂" },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
				},
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
				filetype = {
					-- Sets the icon's highlight group.
					-- If false, will use nvim-web-devicons colors
					custom_colors = false,

					-- Requires `nvim-web-devicons` if `true`
					enabled = true,
				},
				separator = { left = "󰿈", right = "" },

				-- If true, add an additional separator at the end of the buffer list
				separator_at_end = true,

				-- Configure the icons on the bufferline when modified or pinned.
				-- Supports all the base icon options.
				modified = { button = "●" },
				pinned = { button = "", filename = true },

				-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
				preset = "powerline",

				-- Configure the icons on the bufferline based on the visibility of a buffer.
				-- Supports all the base icon options, plus `modified` and `pinned`.
				alternate = { filetype = { enabled = true } },
				current = { buffer_index = true },
				inactive = { button = "×" },
				visible = { modified = { buffer_number = true } },
			},
			-- insert_at_start = true,
		},
		version = "^1.0.0", -- optional: only update when a new 1.x version is released

		config = function()
			require("barbar").setup({
				no_name_title = "untitled",
				tabpages = true,
				clickable = true,
				separator = { left = "󰅂󰅂", right = "" },
			})
		end,
	},
}
