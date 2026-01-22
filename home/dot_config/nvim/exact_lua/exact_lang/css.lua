return {

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = { ensure_installed = { "css-lsp" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
      },
    },
  },

  {
    'cachebag/nvim-tcss',
    opts = {}
  },


}
