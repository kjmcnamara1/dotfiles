return {
  -- Provide popup to help show keymaps
  "folke/which-key.nvim",
  cond = not vim.g.vscode,
  event = "VeryLazy",
  -- cmd = "WhichKey",
  keys = { { "<leader>?", function() require("which-key").show() end, desc = "Buffer Local Keymaps (which-key)" } },
  opts = { preset = "helix" },
  -- init = function()
  --   vim.o.timeout=true
  --   vim.o.timeoutlen=300
  -- end,
}
