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
