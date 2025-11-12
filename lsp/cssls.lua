return {
	cmd = { "css-languageserver", "--stdio" },
	filetypes = { "css", "scss", "less" },
	root_markers = { "package.json", "node_modules" },
	settings = {
		css = { validate = true },
		less = { validate = true },
		scss = { validate = true },
	},
}
