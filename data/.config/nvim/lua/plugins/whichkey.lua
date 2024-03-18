return {
  -- Provide popup to help show keymaps
  "folke/which-key.nvim",
  cond = not vim.g.vscode,
  event = "VeryLazy",
  cmd = "WhichKey",
  -- init = function()
  --   vim.o.timeout=true
  --   vim.o.timeoutlen=300
  -- end,
}
