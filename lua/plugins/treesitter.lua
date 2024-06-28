return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"javascript",
				"html",
				"css",
				"typescript",
				"python",
				"javascript",
				"rust",
				"elixir",
			},
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})
	end,
}
