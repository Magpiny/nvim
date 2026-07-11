local codesnap = {
	"mistricky/codesnap.nvim",
	tag = "v2.0.0", -- optional: pin to stable v2
	-- build = "make", -- no longer needed in v2 (prebuilt binaries are downloaded)
}

codesnap.config = function()
	require("codesnap").setup({
		save_path = os.getenv("HOME") .. "/Pictures/CodeSnippets",
		show_line_number = true,
		show_workspace = true,

		snapshot_config = {
			-- Code theme (you can use built-in like "candy", or a VSCode theme via asset URL)
			theme = "candy",

			window = {
				mac_window_bar = true,
				shadow = {
					radius = 8,
					color = "#00000040",
				},
				margin = {
					x = 30,
					y = 30,
				},
				border = {
					width = 1,
					color = "#ffffff30",
				},
				title_config = {
					color = "#ffffff",
					font_family = "Pacifico",
				},
			},

			code_config = {
				font_family = "Cascadia Code", -- or "CaskaydiaCove Nerd Font", etc.
				breadcrumbs = {
					enable = true,
					separator = "/",
					color = "#80848b",
					font_family = "Cascadia Code",
				},
			},

			watermark = {
				content = "🇰🇪  @mag_piny",
				font_family = "Cascadia Code", -- or any font you like
				color = "#ffffff",
			},

			-- Background: you can use a solid color or gradient
			background = "#1e1e2e", -- solid color example (change as needed)
			-- Or use a gradient (uncomment if preferred):
			-- background = {
			--   start = { x = 0, y = 0 },
			--   ["end"] = { x = "max", y = "max" },
			--   stops = {
			--     { position = 0, color = "#6bcba5" },
			--     { position = 1, color = "#caf4c2" },
			--   },
			-- },
		},
	})
end

return codesnap
