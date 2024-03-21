return {
  {
    "rmehri01/onenord.nvim",
    cond = not vim.g.vscode,
    name = "onenord",
    event = "VimEnter",
    priority = 1000,
    opts = {
      -- fade_nc = true,
      styles = {
        comments = "italic",
        keywords = "bold",
      },
      disable = {
        -- background = true,
        float_background = true,
      },
    },
  },
  {
    "rebelot/kanagawa.nvim",
    cond = not vim.g.vscode,
    name = "kanagawa",
    event = "VeryLazy",
    opts = {
      transparent = true,
      colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
      overrides = function()
        return {
          NormalFloat            = { bg = "none" },
          FloatBorder            = { bg = "none" },
          FloatTitle             = { bg = "none" },
          TelescopePromptBorder  = { bg = "none" },
          TelescopeResultsBorder = { bg = "none" },
          TelescopePreviewBorder = { bg = "none" },
        }
      end,
    },
  },
  {
    "shaunsingh/nord.nvim",
    cond = not vim.g.vscode,
    name = "nord",
    event = "VeryLazy",
  },
  {
    "olimorris/onedarkpro.nvim",
    cond = not vim.g.vscode,
    name = "onedarkpro",
    event = "VeryLazy",
  },
  {
    "navarasu/onedark.nvim",
    cond = not vim.g.vscode,
    name = "onedark",
    event = "VeryLazy",
  },
  {
    "neanias/everforest-nvim",
    cond = not vim.g.vscode,
    name = "everforest",
    event = "VeryLazy",
    version = false,
  },
  {
    "catppuccin/nvim",
    cond = not vim.g.vscode,
    name = "catppuccin",
    event = "VeryLazy",
  },
}
