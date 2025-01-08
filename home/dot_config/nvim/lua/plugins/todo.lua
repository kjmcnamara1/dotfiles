-- ================================================================================
-- * TODO
-- ================================================================================

return {
  "folke/todo-comments.nvim",
  -- dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    keywords = {
      TODO = { color = "todo" },
    },
    colors = {
      todo = { "@comment.todo", "#FFFF00" },
    },
  },
}
