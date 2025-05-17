-- colorscheme

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
