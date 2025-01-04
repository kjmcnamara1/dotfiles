return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    jump = {
      autojump = true,
    },
    label = {
      current = false,
      after = false,
      before = true,
      -- rainbow = { enabled = true }
    },
    modes = {
      search = { enabled = true },
      treesitter = { label = { rainbow = { enabled = true } } },
      treesitter_search = { label = { rainbow = { enabled = true } } },
      remote = { jump = { pos = "range", autojump = false, } },
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
