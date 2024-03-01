
  -- Better than mini.comment
  -- mini.comment does not have block comments (gb, gbc)
  -- mini.comment does not have gcA, gco, gcO
  -- missing 'gc' textobject from mini.comment for ops like 'dgc'
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
    keys = {
      { "<c-_>", function() require("Comment.api").toggle.linewise.current() end, mode = "i", desc = "Toggle comment" },
      { "gc", mode = { "n", "x" } },
      { "gb", mode = { "n", "x" } },
    },
  },
  }
