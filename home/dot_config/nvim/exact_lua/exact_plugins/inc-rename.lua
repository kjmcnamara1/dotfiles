-- do return {} end

return {

  {
    "smjonas/inc-rename.nvim",
    enabled = not vim.g.vscode,
    cmd = "IncRename",
    opts = {},
  },

  {
    "folke/noice.nvim",
    opts = {
      presets = { inc_rename = true },
    },
  }

}
