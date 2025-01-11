-- ================================================================================
-- * TODO Comments
-- ================================================================================

return {
  "folke/todo-comments.nvim",
  -- dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPost", "BufNewFile" },
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
