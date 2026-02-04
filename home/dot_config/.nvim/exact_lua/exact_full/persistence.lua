return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  keys = {
    { "<leader>ss", function() require("persistence").load() end,                desc = "Restore Session" },
    { "<leader>sS", function() require("persistence").select() end,              desc = "Select Session" },
    { "<leader>sL", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    {
      "<c-s-q>",
      function()
        require("persistence").stop(); vim.cmd([[:qa!]])
      end,
      desc = "Quit Neovim without saving session"
    },
  },
  opts = {},
}
