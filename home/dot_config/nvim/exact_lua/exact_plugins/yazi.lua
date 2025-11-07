-- ================================================================================
-- * Yazi
-- ================================================================================

return {
  "mikavilpas/yazi.nvim",
  dependencies = "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    -- open_multiple_tabs = true,
    -- floating_window_scaling_factor = 0.5,
    yazi_floating_window_border = 'none',
    keymaps = {
      show_help = '<f1>',
    },
  },
}
