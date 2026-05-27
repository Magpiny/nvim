-- lua/core/options.lua
-- WANJARE SAMUEL

local opt = vim.opt

-- ── UI ───────────────────────────────────────────────────────────────────────
opt.number         = true
opt.relativenumber = true          -- relative line numbers (great for motions)
opt.cursorline     = true
opt.termguicolors  = true
opt.signcolumn     = "yes"         -- always show; prevents layout jitter
opt.laststatus     = 3             -- single global statusline (0.8+)
opt.showmode       = false         -- lualine shows the mode already
opt.winborder      = "rounded"     -- rounded borders on floating windows (0.11+)
opt.scrolloff      = 10
opt.list           = true
opt.listchars      = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand     = "split"       -- live preview of :s substitutions

-- ── Splits ───────────────────────────────────────────────────────────────────
opt.splitright = true
opt.splitbelow = true

-- ── Indentation ──────────────────────────────────────────────────────────────
opt.tabstop     = 4
opt.softtabstop = 4
opt.shiftwidth  = 4
opt.expandtab   = true
opt.shiftround  = true             -- FIX: was vim.cmd.shiftround (wrong API)
opt.breakindent = true

-- ── Search ───────────────────────────────────────────────────────────────────
opt.ignorecase = true              -- FIX: was abbreviated as opt.ic
opt.smartcase  = true
opt.hlsearch   = true

-- ── Files / undo ─────────────────────────────────────────────────────────────
opt.undofile = true                -- FIX: deduplicated (was set twice)
opt.autoread = true                -- FIX: was vim.cmd.autoread = 2 (wrong API + wrong type)

-- ── Performance ──────────────────────────────────────────────────────────────
opt.updatetime = 250               -- faster CursorHold / gitsigns

-- ── Completion ───────────────────────────────────────────────────────────────
opt.completeopt = { "menuone", "noselect" }

-- ── Misc ─────────────────────────────────────────────────────────────────────
opt.mouse      = "a"
opt.wildignore = { "*.o", "*.a", "*.exe", "*.docx", "*.xlsx", "*.png", "*.jpg", "*.pdf" }

-- REMOVED (were Neovim defaults — setting them is a no-op or a downgrade):
--   autoindent, smarttab, showcmd, history = 1000, backspace = "2"
