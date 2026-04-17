return {
	--command to start and run the server
	cmd = { "lua-language-server" },

	-- file types to automaticaly attach to
	filetypes = { "lua" },

	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.

	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	--
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize 'vim' global
				globals = { "vim" },
			},
			signatureHelp = { enabled = true },
		},
	},
}
