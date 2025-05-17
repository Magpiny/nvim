--[[ 
--
--WANJARE SAMUEL neovim config file
    licenced under MIT
  01/06/2024: This one was a joy to work on given my limited knowledge of lua
  But I finally hacked it! ... and it's the best confing I've ever made from ground up
  Thanks to Google, Youtube and GeminiAI and (Nvim, nvim &or vim extension developers)

  LAST UPDATED: 17May2025
]]
--
require("core.options")

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- vim.g:clang_format#options = '-std=c++23'

vim.g.have_nerd_font = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("lazy").setup("plugins")

-- colorscheme kanagawa
--
vim.cmd("colorscheme kanagawa-dragon")

-- keymaps
require("core.keymaps")

------------------------------------- END ---------------------------------------------------------
