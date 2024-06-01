-- colorscheme
--[[
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,

	config = function()
		require("catppuccin").setup({
			integrations = {
				treesitter = true,
				treesitter_context = true,
				cmp = true,
				nvimtree = true,
				notify = true,
				mini = {
					enabled = true,
				},
				gitsigns = true,
				telescope = true,
			},
		})
	end,
}
--]]
--

-- Kanagawa
return {
	"rebelot/kanagawa.nvim",
	lazy = true,
	config = function()
		-- :KanagawaCompile after each change
		require("kanagawa").setup({
			compile = true,
		})
	end,
}
