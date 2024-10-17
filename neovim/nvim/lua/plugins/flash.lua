return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>f", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "<leader>F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Trweesitter", },
      { "r",         mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash", },
      { "R",         mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
      -- { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search", },
    },
    opts = {
      jump = {
        autojump = true,
      },
      label = {
        current = false,
      },
      modes = {
        search = { enabled = false },
        char = { enabled = false },
      },
    },
    init = function()
      vim.keymap.del({ "n", "x", "o" }, "f")
      vim.keymap.del({ "n", "x", "o" }, "F")
    end,
  },
}
