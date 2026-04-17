return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true, -- Close Neovim if only the sidebar is left
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none", -- Disable space so it doesn't conflict with your leader
        },
      },
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = {
            "node_modules",
            "target", -- Hide Rust build artifacts
            "build",  -- Hide C++ build artifacts
          },
        },
        follow_current_file = { enabled = true }, -- Sync sidebar with open buffer
      },
    })

    -- TOGGLE KEYMAP: Using <leader>e instead of CTRL+v to avoid conflicts
    vim.keymap.set("n", "<leader>e", "<CMD>Neotree toggle<CR>", { desc = "Toggle Explorer" })
  end,
}
