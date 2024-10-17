return {
  {
    -- Adds labels for marks to sign column and several keymaps
    "kshenoy/vim-signature",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- Change background highlight to match color of string, e.g. '#abf4c2'
    "brenoprata10/nvim-highlight-colors",
    cond = not vim.g.vscode,
    event = "BufReadPost",
    config = true,
  },
  {
    -- Maximize window and restore
    "declancm/maximize.nvim",
    cond = not vim.g.vscode,
    keys = {
      { "<F3>", function() require("maximize").toggle() end, mode = { "i", "n", "v", "t" }, desc = "Toggle maximize window" },
    },
    opts = { default_keymaps = false },
  },
  {
    -- Distraction free interface
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode", mode = { "n", "v" } }
    },
    opts = {
      window = {
        options = {
          -- signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
          scrolloff = 999,
        }
      },
      plugins = {
        options = {
          enabled = true,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        wezterm = { enabled = true, font = "+2" },
      },
    }
  },
}
