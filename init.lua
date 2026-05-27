--[[
  WANJARE SAMUEL — Neovim config
  Licence: MIT
  Last updated: 2025-05-17
  Target: Neovim 0.11+
]]

-- ── Disable netrw (using neo-tree instead) ───────────────────────────────────
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- ── Leaders — must be a asaet BEFORE any plugin/keymap loads ─────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Fix: ensure avante's compiled .so files are found before other plugins
local avante_build = vim.fn.stdpath("data") .. "/lazy/avante.nvim/build"
package.cpath = avante_build .. "/?.so;" .. package.cpath

-- ── Core options ─────────────────────────────────────────────────────────────
require("core.options")

-- ── Bootstrap lazy.nvim ──────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- FIX: vim.uv directly (vim.loop is deprecated in 0.11)
if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ── Plugins — Lazy scans every file under lua/plugins/ ───────────────────────
require("lazy").setup("plugins", {
	change_detection = { notify = false },
})

-- ── LSP ──────────────────────────────────────────────────────────────────────
require("core.lsp")

-- ── Keymaps ──────────────────────────────────────────────────────────────────
require("core.keymaps")

-- ── Treesitter ───────────────────────────────────────────────────────────────
--  require("config.treesitter")

-- ── Colorscheme — loaded last so plugins have set up highlight groups ─────────
vim.cmd.colorscheme("kanagawa-dragon")
