vim.filetype.add({
  pattern = {
    [".*/hypr/.*.conf"] = "hyprlang",
  },
})

return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hyprls = {},
      },
    },
  },

}
