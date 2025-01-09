-- ================================================================================
-- * Trouble
-- ================================================================================
-- TODO: Configure Trouble

-- vim.api.nvim_create_autocmd('FileType',{
--   desc="Trouble options"
-- })

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {
    keys = {
      h = "fold_close",
      l = "fold_open",
      H = "fold_close_recursive",
      L = "fold_open_recursive",
    },
    win = { scrolloff = 5, },
    modes = {
      todo = {
        win = { position = "right" },
      },
    },
  },
}
