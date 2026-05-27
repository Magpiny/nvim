-- lua/plugins/mason.lua
return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"vtsls",
					"html",
					"lua_ls",
					"pyright",
					"clangd",
					"rust_analyzer",
					"cssls",
					"neocmake",
					"jsonls",
					"bashls",
				},
				-- FIX: automatic_installation is deprecated in mason-lspconfig v2
				-- New option is automatic_enable; but since we call vim.lsp.enable()
				-- manually in core/lsp.lua, we leave this false to avoid double-enabling.
				automatic_enable = false,
			})
		end,
	},
}
