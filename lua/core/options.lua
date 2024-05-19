-- WANJARE SAMUEL
-- my editor options config
--

vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.backspace = '2'
vim.opt.ic = true
vim.opt.showcmd = true
vim.cmd.shiftround = 2
vim.cmd.autoread = 2
vim.opt.showmode = true
vim.opt.history = 1000
vim.opt.wildignore = {'*.o','*.a','*img','*exe','*.docx','*.xlsx','*.png','*.jpg','.pdf'}
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
	    
vim.cmd([[
    syntax enable
	filetype on
    filetype plugin on
	filetype plugin indent on
	:set mouse=a
	:set encoding=UTF-8
]])

