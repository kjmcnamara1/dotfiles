-- ================================================================================
-- * TODO
-- ================================================================================

return {
  "folke/todo-comments.nvim",
  cond = not vim.g.vscode,
  dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
  },
  opts = {
    keywords = {
      TODO = { color = "todo" },
    },
    colors = {
      todo = { "@comment.todo", "#FFFF00" },
    },
  },
}
