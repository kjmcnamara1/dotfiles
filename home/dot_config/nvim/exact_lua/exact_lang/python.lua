vim.filetype.add({
  extension = {
    ipy = "python",
    xsh = "xonsh",
  }
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Custom Python Settings",
  group = vim.api.nvim_create_augroup('Xonsh', { clear = true }),
  pattern = 'xonsh',
  callback = function()
    -- vim.opt.formatoptions:remove('o')
    vim.bo.commentstring = '# %s'
  end
})

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
    keys = {
      { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" }
    },
    opts = {
      settings = {
        options = {
          notify_user_on_venv_activation = true,
        },
      },
    },
  },

  {
    "linkinpark342/xonsh-vim",
    ft = "xonsh",
  },


  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        xonsh = "# %s",
      },
    },
  },

}
