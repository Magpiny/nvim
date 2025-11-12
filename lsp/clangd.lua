-- C++ tuning in neovim;
return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--header-insertion=iwyu", -- Suggests #include fixes via include-what-you-use
		"--header-insertion-decorators=0", -- Disable decorative underlines for cleaner UI
		"--inlay-hints", -- Enable inlay hints (requires Neovim 0.10+)
		"--pch-storage=memory", -- Faster precompiled headers (if memory allows)
	},

	filetypes = { "c", "cpp" },

	root_markers = {
		"compile_commands.json", -- From CMake (`cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..`)
		".clangd", -- Clangd config file
		"CMakeLists.txt", -- CMake projects
		".git", -- Git repo fallback
	},

	-- Capabilities for advanced features (semantic tokens, folding ranges)
	capabilities = {
		textDocument = {
			semanticTokens = {
				provider = "client", -- Better syntax highlighting
			},
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},

	-- Namespaced settings for clangd
	settings = {
		clangd = {
			-- Enforce C++23 dialect (appends to compile flags; overridden by compile_commands.json)
			compileFlags = {
				add = { "-std=c++23" },
				-- Optional: Remove if you want stricter warnings
				remove = { "-Wunused-parameter" }, -- Example: Suppress common false positives
			},
			-- Diagnostics tweaks
			diagnostics = {
				unusedIncludes = "strict", -- Strict unused #include detection
				missingIncludes = "strict", -- Error on missing headers
				suppress = { "ClangTidy" }, -- Optional: Mute specific tidy checks
			},
			-- Completion settings
			completion = {
				detailedLabel = false, -- Shorter completion labels
				enableSnippets = true, -- Use snippets (if you have a snippet engine like luasnip)
			},
			-- Indexing for faster startup
			index = {
				background = true,
				implicitIndex = {
					includePatterns = { "**/*.h", "**/*.hpp" }, -- Index headers too
				},
			},
			-- Code actions (e.g., fix includes, refactor)
			codeAction = {
				includeFix = true,
				kind = {
					valueSet = 1, -- Use clangd's preferred kinds
				},
			},
		},
	},

	-- Optional: Custom root_dir for non-standard projects (e.g., Makefile-based)
	-- root_dir = function(fname)
	--   return require("lspconfig.util").root_pattern("compile_commands.json", ".clangd", "CMakeLists.txt", ".git")(fname)
	--     or vim.fn.getcwd()
	-- end,
}
