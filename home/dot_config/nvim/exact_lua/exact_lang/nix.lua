return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },

}
