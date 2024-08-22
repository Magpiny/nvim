return {
	"adigitoleo/haunt.nvim",
	config = function()
		require("haunt").setup({
			define_commands = true,
		})
	end,
}
