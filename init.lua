--[[ 
--
--WANJARE SAMUEL neovim config file
    licenced under MIT
  01/06/2024: This one was a joy to work on given my limited knowledge of lua
  But I finally hacked it! ... and it's the best confing I've ever made from ground up
  Thanks to Google, Youtube and GeminiAI and (Nvim, nvim &or vim extension developers)
  I may use this config for some years to come.
    Font:ComicShannsMono Nerd Font ColorScheme:kanagawa-dragon Terminal:GnomeTerminal
]]
--
require("core.options")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- colorscheme catppuccin
--vim.cmd.colorscheme("catppuccin")
vim.cmd("colorscheme kanagawa-dragon")

-- keymaps
require("core.keymaps")

------------------------------------- END ---------------------------------------------------------
