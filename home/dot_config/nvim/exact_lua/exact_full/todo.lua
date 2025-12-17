-- ================================================================================
-- * TODO Comments
-- ================================================================================

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
  },
  opts = {
    keywords = {
      TODO = { color = "todo" },
    },
    highlight = {
      pattern = [[^\W*<(KEYWORDS):]] -- only highlight comments that START with keyword
    },
    colors = {
      todo = { "@comment.todo", "#FFFF00" },
    },
    search = {
      pattern = [[^\W*\b(KEYWORDS):]], -- only search comments that START with keyword
    },
  },
}
