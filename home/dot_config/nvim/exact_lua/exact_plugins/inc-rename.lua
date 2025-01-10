-- do return {} end

return {

  {
    "smjonas/inc-rename.nvim",
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
