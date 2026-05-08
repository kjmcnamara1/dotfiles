-- ================================================================================
-- * BufferLine
-- ================================================================================

-- TODO:  Maybe check out barbar.nvim https://github.com/romgrk/barbar.nvim
return {
  "akinsho/bufferline.nvim",
  -- enabled = not vim.g.vscode,
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "folke/snacks.nvim",
    -- { "backdround/tabscope.nvim", config = true },
  },
  keys = {
    { "<leader>'",  "<cmd>e #<cr>",                            desc = "Alternate Buffer" },
    { "<leader>bn", "<cmd>enew<cr>",                           desc = "New file" },
    { "<leader>bb", "<cmd>BufferLinePick<cr>",                 desc = "Pick buffer" },
    { "<leader>bx", "<cmd>BufferLinePickClose<cr>",            desc = "Pick buffer to close" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Toggle pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",          desc = "Delete other buffers" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
    { "<a-s-l>",    "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
    { "<a-s-h>",    "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
    { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
    { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
    -- { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
    -- { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
    -- { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer right" },
    -- { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer left" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
      close_command = function(n) Snacks.bufdelete(n) end,
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
    },
  },
}
