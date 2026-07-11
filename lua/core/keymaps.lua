-- lua/core/keymaps.lua
-- WANJARE SAMUEL
--  shortcut keys (keymaps)

local map = vim.keymap.set

-- ── General ──────────────────────────────────────────────────────────────────
-- FIX: was "<leader> h" (space before h = Space-Space-h, not Space-h)
map("n", "<leader>h", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ── File tree ────────────────────────────────────────────────────────────────
-- FIX: removed <C-v> → Neotree (shadowed Visual Block mode)
-- <leader>e is set by filetree.lua; kept here too for discoverability
map("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "Explorer: Toggle" })

-- ── Tagbar ───────────────────────────────────────────────────────────────────
map("n", "<F8>", "<cmd>TagbarToggle<CR>", { desc = "Tagbar: Toggle" })

-- ── Terminal ─────────────────────────────────────────────────────────────────
map("n", "<C-t>", "<cmd>HauntTerm -t magpiny<CR>", { desc = "Terminal: Open haunt" })

-- ── Telescope ────────────────────────────────────────────────────────────────
-- FIX: was require("telescope.builtin") at top level → crashes before Lazy loads telescope
-- Wrap in functions so telescope is only required when the key is pressed
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Telescope: Find files" })
map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Telescope: Live grep" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Telescope: Buffers" })
map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Telescope: Help tags" })

-- ── Barbar buffer navigation ──────────────────────────────────────────────────
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { desc = "Buffer: Previous", silent = true })
map("n", "<A-.>", "<Cmd>BufferNext<CR>", { desc = "Buffer: Next", silent = true })
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { desc = "Buffer: Move left", silent = true })
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { desc = "Buffer: Move right", silent = true })
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { desc = "Buffer: Goto 1", silent = true })
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { desc = "Buffer: Goto 2", silent = true })
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { desc = "Buffer: Goto 3", silent = true })
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { desc = "Buffer: Goto 4", silent = true })
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { desc = "Buffer: Goto 5", silent = true })
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { desc = "Buffer: Goto 6", silent = true })
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { desc = "Buffer: Goto 7", silent = true })
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { desc = "Buffer: Goto 8", silent = true })
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { desc = "Buffer: Goto 9", silent = true })
map("n", "<A-0>", "<Cmd>BufferLast<CR>", { desc = "Buffer: Last", silent = true })
map("n", "<A-p>", "<Cmd>BufferPin<CR>", { desc = "Buffer: Pin/unpin", silent = true })
map("n", "<A-c>", "<Cmd>BufferClose<CR>", { desc = "Buffer: Close", silent = true })
map("n", "<C-p>", "<Cmd>BufferPick<CR>", { desc = "Buffer: Pick", silent = true })
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { desc = "Buffer: Sort by number", silent = true })
map("n", "<Space>bn", "<Cmd>BufferOrderByName<CR>", { desc = "Buffer: Sort by name", silent = true })
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "Buffer: Sort by directory", silent = true })
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "Buffer: Sort by language", silent = true })
map("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { desc = "Buffer: Sort by window", silent = true })

vim.keymap.set("x", "<leader>CS", "<cmd>CodeSnap<cr>", { desc = "CodeSnap to clipboard" })
vim.keymap.set("x", "<leader>CS", "<cmd>CodeSnapSave<cr>", { desc = "CodeSnap save to file" })

-- NOTE: DAP keymaps are intentionally NOT defined here.
-- They are declared inside plugins/debug.lua via Lazy's `keys = {}` table,
-- which is the correct pattern — it also lazy-loads nvim-dap on first use.
