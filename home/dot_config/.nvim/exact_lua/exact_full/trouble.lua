-- ================================================================================
-- * Trouble
-- ================================================================================

-- TODO: add keymap for changing todo levels (same as toggle severity filter)
return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                                  desc = "Diagnostics (Trouble)", },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                     desc = "Buffer Diagnostics (Trouble)", },
    { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                          desc = "Symbols (Trouble)", },
    { "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>",                              desc = "LSP Definitions / references / ... (Trouble)", },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                                      desc = "Location List (Trouble)", },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                                       desc = "Quickfix List (Trouble)", },
    { "<leader>xt", "<cmd>Trouble todo toggle focus filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    { "<leader>xT", "<cmd>Trouble todo toggle<cr>",                                         desc = "Todo (Trouble)" },
  },
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
        -- wrap = true,
      },
    },
    modes = {
      lsp = {
        win = { position = "right" },
      },
      -- todo = {
      --   win = { position = "right" },
      -- },
    },
  },
}
