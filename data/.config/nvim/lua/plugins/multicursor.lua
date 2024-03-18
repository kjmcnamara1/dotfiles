return {
  {
    "mg979/vim-visual-multi",
    cond = not vim.g.vscode,
  },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    cond = not not vim.g.vscode,
    event = "VeryLazy",
    opts = {},
  }
}
