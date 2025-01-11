-- ================================================================================
-- * Trouble
-- ================================================================================

-- TODO: add keymap for changing todo levels (same as toggle severity filter)
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
    indent_guides = false,
    win = {
      wo = {
        scrolloff = 5,
      },
    },
    modes = {
      lsp = {
        win = { position = "right" },
      },
      todo = {
        win = { position = "right" },
      },
    },
  },
}
