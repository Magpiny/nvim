-- lua/plugins/markdown.lua
return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	config = function()
		require("render-markdown").setup({
			enabled = true,
			-- FIX: was max_file_size = 15 → that is 15 BYTES, disabling rendering on all real files.
			-- 1.5 MB is a sane upper limit.
			max_file_size = 1.5, -- MB
		})
	end,
}
