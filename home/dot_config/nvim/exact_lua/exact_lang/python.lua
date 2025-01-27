return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              lint = {
                select = { "E", "F", "B", "ISC", "SIM", "TC", "PD" },
                ignore = { "F401", "PD901", "F841" },
              }
            },
          },
        },
        pyright = {},
      },
    },
  },

  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp", -- Use this branch for the new version
    cmd = "VenvSelect",
    ft = "python",
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
  },

}
