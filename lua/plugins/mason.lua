return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},

	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"tsserver",
				"html",
				"tailwindcss",
				"lua_ls",
				"pyright",
				"clangd",
				"jinja_lsp",
				"rust_analyzer",
				"clangd",
				"cssls",
				"cmake",
				"jsonls",
				"elixirls",
			},
			-- autoinstall configured servers with lspconfig
			automatic_installation = true,
		})
	end,
}
