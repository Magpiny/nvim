return {
	--command to start and run the server
	cmd = { "rust-analyzer" },

	-- file types to automaticaly attach to
	filetypes = { "rust" },

	-- Sets the "workspace" to the directory where any of these files is found.
	-- Files that share a root directory will reuse the LSP server connection.
	-- Nested lists indicate equal priority, see |vim.lsp.Config|.

	root_markers = {
		"Cargo.toml",
		".git",
	},
	-- Specific settings to send to the server. The schema is server-defined.
	-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
	--
	settings = {
		autoformat = true,
		check = {
			command = "clippy",
		},
		-- Optional: Enable inlay hints (modern C++-like type hints)
		inlayHints = {
			locationLinks = true,
		},
		-- Optional: Cargo-specific tweaks (e.g., build scripts)
		cargo = {
			buildScripts = {
				enable = true,
			},
		},
	},
}
