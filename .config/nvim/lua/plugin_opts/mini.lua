return {
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = true,
    enabled = false,
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      opts = {
        enable_autocmd = false,
      },
    },
    opts = {
      options = {
        ignore_blank_line = true,
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
    keys = {
      "gcc",
      { "gc", mode = { "n", "x" } },
      {
        "<c-_>", -- 'Ctrl-/'
        function()
          local line_num = vim.api.nvim_win_get_cursor(0)[1]
          require("mini.comment").toggle_lines(line_num, line_num)
        end,
        mode = "i",
        desc = "Toggle comment line",
      },
    },
  },
}
