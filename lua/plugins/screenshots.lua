-- local codesnap = { "mistricky/codesnap.nvim", build = "make" }
local codesnap = { "mistricky/codesnap.nvim", build = "make build_generator" } -- compiling from source

function codesnap.config()
	require("codesnap").setup({
		save_path = "~/Pictures/CodeSnippets",
		bg_theme = "bamboo",
		watermark_font_family = "Cascadia Code",
		watermark = "🇰🇪 @mag_piny  🏇",
	})
end

return codesnap
