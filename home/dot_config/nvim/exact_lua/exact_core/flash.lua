return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s",     function() require("flash").jump() end,              desc = "Flash",               mode = { "n", "x", "o" } },
    { "S",     function() require("flash").treesitter() end,        desc = "Flash Trweesitter",   mode = { "n", "o" } },
    { "r",     function() require("flash").remote() end,            desc = "Remote Flash",        mode = "o" },
    { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",   mode = { "o", "x" } },
    { "<c-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search", mode = { "c" } },
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
      treesitter = {
        label = {
          style = "overlay",
          rainbow = {
            enabled = true
          }
        }
      },
      treesitter_search = {
        label = {
          style = "overlay",
          rainbow = {
            enabled = true
          }
        }
      },
      remote = {
        jump = {
          pos = "range",
          autojump = false,
        }
      },
      char = {
        char_actions = function(motion)
          return {
            [','] = "next",
            [';'] = "prev",
            [motion:lower()] = "right",
            [motion:upper()] = "left",
          }
        end,
      },
    },
  },
}
