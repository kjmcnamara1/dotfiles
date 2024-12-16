return {

  -- ================================================================================
  -- * Comment
  -- ================================================================================
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
    keys = {
      { "<c-/>", function() require("Comment.api").toggle.linewise.current() end, mode = { "i", "n", "x" }, desc = "Toggle line comment" },
      { "gc",    mode = { "n", "x" } },
      { "gb",    mode = { "n", "x" } },
    },
  },

}
