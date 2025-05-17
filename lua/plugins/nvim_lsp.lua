-- LSP configuration
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- nvim kemap settings/bindings
		local keymap = vim.keymap
		local opts = { noremap = true, silent = true }

		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			--set keybinds
			opts.desc = "Show references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "SHow buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

			opts.desc = "Show documentation for what is under the cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
		end

		-- Enable autocompletions
		--local capabilities = cmp_nvim_lsp.default_capabilities()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Diagnostic Signs
		local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- Enable some language servers with the additional completion capabilities offered by nvim-cmp

		--- configure language servers
		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.clangd.setup({

			cmd = {
				"clangd",
				"--background-index",
				"--suggest-missing-includes",
				"--clang-tidy",
				"--header-insertion=iwyu",
				"--header-insertion-decorators",
				"--completion-style=detailed",
				"--function-arg-placeholders",
			},

			init_options = {
				fallbackFlags = { "-std=c++23", "-Wall" },
			},

			on_attach = function(client, bufnr)
				-- Enable formatting with clang-format
				vim.api.nvim_create_autocmd("BufWritePre", {
					pattern = ".cpp,.hpp,.cxx,.hxx,.C,.c,.h",
					callback = function()
						vim.lsp.buf.format({
							timeout_ms = 5000,
							async = false,
						})
					end,
				})
			end,
			root_dir = vim.fn.getcwd(),

			capabilities = capabilities,

			filetypes = { "c", "cpp" },
		})

		-- Configure clang-format style
		local clang_format_style = {
			BasedOnStyle = "Webkit",
			UseTab = "Never",
			IndentWidth = 4,
			SpaceBeforeTrailingComments = 1,
			BreakBeforeBraces = "Linux",
			AllowShortFunctionsOnASingleLine = false,
			AllowShortIfStatementsOnASingleLine = false,
			SpaceAfterFunctionName = true,
			PointerAlignment = "Left",
			SpaceBeforeParens = "ControlStatements",
		}

		-- Set the style for clang-format
		vim.g.clang_format_style = vim.json.encode(clang_format_style)

		-- Use clang-format for fromatting
		vim.api.nvim_create_user_command("Format", function()
			vim.lsp.buf.format({ name = "clangd" })
		end, {})

		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,

			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
		lspconfig.bashls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.cmake.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.sqlls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.filetype.add({
			extension = {
				jinja = "jinja",
				jinja2 = "jinja",
				j2 = "jinja",
			},
		})
		require("lspconfig").jinja_lsp.setup({})
	end,
}
