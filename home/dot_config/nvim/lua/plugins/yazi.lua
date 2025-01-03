-- ================================================================================
-- * Yazi
-- ================================================================================
---@type LazySpec

return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>y.", "<cmd>Yazi<cr>",        desc = "Open yazi at the current file", },
    { "<leader>yc", "<cmd>Yazi cwd<cr>",    desc = "Open yazi in nvim's working directory", },
    { '<leader>yy', "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
  },
  ---@type YaziConfig
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
