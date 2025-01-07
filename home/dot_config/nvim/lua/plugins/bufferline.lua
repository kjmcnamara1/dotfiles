-- ================================================================================
-- * BufferLine
-- ================================================================================

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "folke/snacks.nvim",
    -- { "backdround/tabscope.nvim", config = true },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      -- separator_style = "slant",
      -- separator_style = { "", "" },
      -- indicator = { style = "none" },
      -- TODO: might need to add diagnostics_indicator after configuring lsp
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
