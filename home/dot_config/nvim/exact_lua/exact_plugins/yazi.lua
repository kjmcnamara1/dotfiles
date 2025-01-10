-- ================================================================================
-- * Yazi
-- ================================================================================

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = true,
    open_multiple_tabs = true,
    floating_window_scaling_factor = 0.75,
    -- yazi_floating_window_border = 'none',
    -- keymaps = {
    --   show_help = '<f1>',
    -- },
  },
}
