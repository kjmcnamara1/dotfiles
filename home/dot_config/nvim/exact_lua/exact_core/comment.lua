-- ================================================================================
-- * Comment
-- ================================================================================

return {

  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    keys = {
      { "<c-/>", function() require("Comment.api").toggle.linewise.current() end, mode = { "i", "n", "x" }, desc = "Toggle line comment" },
      { "gc",    desc = "Line comment",                                           mode = { "n", "x" } },
      { "gb",    desc = "Block comment",                                          mode = { "n", "x" } },
    },
    opts = {
      ignore = "^%s*$", -- Ignore blank lines
      pre_hook = function()
        require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      end,
    },
  },

  -- Define commentstring for additional languages
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  }

}
