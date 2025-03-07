return {
  "3rd/image.nvim",
  enabled = not vim.g.vscode and jit.os ~= "Windows",
  build = false,
  opts = {
    processor = "magick_cli",
  },
}
