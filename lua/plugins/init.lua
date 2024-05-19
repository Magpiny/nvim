-- Note: this is where you can add plugins that don't require any configuration.
-- as soon as you need to add options to a plugin consider making a dedicated file.

local Plugins = {

	{ "tpope/vim-repeat" },
	{ "tpope/vim-fugitive" },
	{ "nvim-treesitter/nvim-treesitter" },
	{ "stevearc/dressing.nvim", opts = {} },
	{ "folke/which-key.nvim" },
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{ "folke/neodev.nvim" },

	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "preservim/tagbar" },

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}

return Plugins
