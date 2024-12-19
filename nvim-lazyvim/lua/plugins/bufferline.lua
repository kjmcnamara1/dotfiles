return {
  "akinsho/bufferline.nvim",
  keys = {
    { "<leader>bb", "<cmd>BufferLinePick<cr>",        desc = "Pick buffer" },
    { "<leader>bx", "<cmd>BufferLinePickClose<cr>",   desc = "Pick buffer to close" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Delete other buffers" },
    { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",    desc = "Move buffer right" },
    { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",    desc = "Move buffer left" },
    { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer" },
    { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer" },
  },
  opts = {
    options = {
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
    },
  },
}
