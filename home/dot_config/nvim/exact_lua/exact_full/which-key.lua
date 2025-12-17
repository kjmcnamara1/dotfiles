-- ================================================================================
-- * Which Key
-- ================================================================================

return {
  "folke/which-key.nvim",
  dependencies = {
    -- "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
  },
  event = "VeryLazy",
  keys = {
    { "<s-f1>", function() require("which-key").show() end,                   desc = "Keymaps (which-key)",        mode = { "n", "i", "x" } },
    { "<f1>",   function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)", mode = { "n", "i", "x" } },
  },
  opts_extend = { "spec" },
  opts = {
    preset = "helix",
    win = { border = "none", },
    spec = {
      mode = { "n", "v" },
      { "<leader><tab>", group = "tabs" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>gh", group = "hub" },
      { "<leader>s", group = "search" },
      { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
      { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "m", group = "surround" },
      { "mc", group = "multicursor" },
      { "z", group = "fold" },
      {
        "<leader>b",
        group = "buffer",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<leader>w",
        group = "windows",
        proxy = "<c-w>",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
  },
}
