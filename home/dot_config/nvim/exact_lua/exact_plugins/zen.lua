-- ================================================================================
-- * Zen Mode
-- ================================================================================

return {
  {
    -- Distraction free interface
    "folke/zen-mode.nvim",
    enabled = false,
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
  }
}
