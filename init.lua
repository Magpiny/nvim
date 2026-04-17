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
--
-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 1. Set Leaders first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Load basic options
require("core.options")

-- 3. Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"

    -- Use vim.fn.system to clone, and capture the output
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })

    -- Fundamental Fix: Check if the system command actually worked
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- 4. Setup Plugins (This loads everything in the plugins/ folder)
require("lazy").setup("plugins")

-- 5. Load LSP and Keymaps AFTER plugins are initialized
require("core.lsp")
require("core.keymaps")

-- 6. Native treesitter (no plugin needed on Neovim 0.12+)
require("config.treesitter")

-- 6. Colorscheme (Ensure this is loaded after Lazy)
vim.cmd("colorscheme kanagawa-dragon")
------------------------------------- END ---------------------------------------------------------
