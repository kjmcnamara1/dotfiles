return {
  -- Tab line
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.bufremove",   -- Better algorithm for display after closing a buffer
  },
  keys = {
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",                            desc = "Toggle pin" },
    { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>",                 desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",                          desc = "Delete other buffers" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",                             desc = "Move buffer right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",                             desc = "Move buffer left" },
    { "<leader>,",  "<cmd>BufferLinePick<cr>",                                 desc = "Pick buffer" },
    { "<leader>x",  "<cmd>BufferLinePickClose<cr>",                            desc = "Pick buffer to close" },
    { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer",              mode = { "n", "i", "v", "c", "t" } },
    { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer",              mode = { "n", "i", "v", "c", "t" } },
    { "[b",         "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer" },
    { "]b",         "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer" },
    { "<c-x>",      function() require("mini.bufremove").delete(0, false) end, desc = "Quit Buffer",              mode = { "n", "i", "v" } },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      -- separator_style = 'slope',
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
        require("mini.bufremove").delete(n, false)
      end,
      right_mouse_command = function(n)
        require("mini.bufremove").delete(n, false)
      end,
    },
  },
}
