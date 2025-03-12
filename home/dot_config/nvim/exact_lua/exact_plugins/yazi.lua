-- ================================================================================
-- * Yazi
-- ================================================================================

return {
  "mikavilpas/yazi.nvim",
  dependencies = "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    -- if you want to open yazi instead of netrw, see below for more info
    open_for_directories = true,
    -- open_multiple_tabs = true,
    floating_window_scaling_factor = 0.5,
    yazi_floating_window_border = 'none',
    keymaps = {
      show_help = '<f1>',
    },
  },
  -- 👇 if you use `open_for_directories=true`, this is recommended
  init = function()
    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
}
