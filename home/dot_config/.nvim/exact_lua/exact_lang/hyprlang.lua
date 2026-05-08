vim.filetype.add({
  pattern = {
    [".*/hypr/.*.conf"] = "hyprlang",
  },
})

return {

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = { ensure_installed = { "hyprls" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hyprls = {},
      },
    },
  },

}
