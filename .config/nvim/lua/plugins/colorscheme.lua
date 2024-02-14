return {

  {
    "rmehri01/onenord.nvim",
    name = "onenord",
    event = "VimEnter",
    priority = 1000,
    opts = {
      fade_nc = true,
      styles = {
        -- comments = "italic",
        keywords = "bold",
      },
      -- TODO: Need to add override for Neo-tree focused file 'NeoTreeCursorLine'
    },
  },
  {
    "shaunsingh/nord.nvim",
    name = "nord",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro",
    event = "VeryLazy",
  },
  {
    "navarasu/onedark.nvim",
    name = "onedark",
    event = "VeryLazy",
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    event = "VeryLazy",
    version = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
  },

}
