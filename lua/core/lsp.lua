-- Enable all your lsp here
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"python_ls",
	"ts_ls",
	"js_ls",
	"rust_analyzer",
	"docker_compose_language_service",
	"awk_ls",
	"html",
	"cssls",
	"bashls",
	"cmake",
	"djlsp",
	"jinja_lsp",
})

-- Enable completions
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end

		vim.diagnostic.config({
			virtual_text = { current_line = true },
			virtual_lines = { current_line = true },
		})

		-- Inlay hints (shows parameter names, types inline like VS Code)
		if client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
		end

		-- Signature help (shows function signature while typing)
		if client:supports_method("textDocument/signatureHelp") then
			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = ev.buf, desc = "Signature help" })
		end

		-- Document symbols (outline view)
		if client:supports_method("textDocument/documentSymbol") then
			vim.keymap.set("n", "gd", vim.lsp.buf.document_symbol, { buffer = ev.buf, desc = "Document symbols" })
		end
	end,
})

-- sth sth
vim.cmd("set completeopt+=noselect")
vim.lsp.buf.add_workspace_folder()
