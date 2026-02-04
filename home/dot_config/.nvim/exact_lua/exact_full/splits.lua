-- ================================================================================
-- * Navigation
-- ================================================================================

return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    { "<c-h>",   function() require("smart-splits").move_cursor_left() end },
    { "<c-j>",   function() require("smart-splits").move_cursor_down() end },
    { "<c-k>",   function() require("smart-splits").move_cursor_up() end },
    { "<c-l>",   function() require("smart-splits").move_cursor_right() end },
    { "<c-\\>",  function() require("smart-splits").move_cursor_previous() end },
    { "<c-a-h>", function() require("smart-splits").resize_left() end },
    { "<c-a-j>", function() require("smart-splits").resize_down() end },
    { "<c-a-k>", function() require("smart-splits").resize_up() end },
    { "<c-a-l>", function() require("smart-splits").resize_right() end },
    { "<c-w>R",  function() require("smart-splits").start_resize_mode() end },
    { "<c-s-h>", function() require("smart-splits").swap_buf_left() end },
    { "<c-s-j>", function() require("smart-splits").swap_buf_down() end },
    { "<c-s-k>", function() require("smart-splits").swap_buf_up() end },
    { "<c-s-l>", function() require("smart-splits").swap_buf_right() end },
  },
  opts = {
    default_amount = 3,
    at_edge = "stop",
    cursor_follows_swapped_bufs = true
  },
}
