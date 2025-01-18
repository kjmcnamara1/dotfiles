return {
  "sindrets/diffview.nvim",
  enabled = not vim.g.vscode,
  -- lazy = true,
  -- dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles' },
  opts = {},
}
