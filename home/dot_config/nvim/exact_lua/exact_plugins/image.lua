return {
  "3rd/image.nvim",
  enabled = not vim.g.vscode,
  build = false,
  opts = {
    processor = "magick_cli",
  },
}
