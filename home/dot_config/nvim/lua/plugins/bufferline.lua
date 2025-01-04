-- ================================================================================
-- * BufferLine
-- ================================================================================

return {
  "bufferline.nvim",
  enabled = false,
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
    -- { "backdround/tabscope.nvim", config = true },
  },
  keys = {
    { "<leader>bb", "<cmd>BufferLinePick<cr>",                 desc = "Pick buffer" },
    { "<leader>bx", "<cmd>BufferLinePickClose<cr>",            desc = "Pick buffer to close" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Toggle pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",          desc = "Delete other buffers" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
    { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
    { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      -- separator_style = "slant",
      -- separator_style = { "", "" },
      -- indicator = { style = "none" },
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
      close_command = function(n)
        Snacks.bufdelete(n)
        -- require("tabscope").remove_tab_buffer(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
        -- require("mini.bufremove").delete(n, false)
        -- require("tabscope").remove_tab_buffer(n)
      end,
    },
  },
}
