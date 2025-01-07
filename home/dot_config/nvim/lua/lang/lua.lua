return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              -- use double quotes
              format = {
                defaultConfig = {
                  quote_style = "double",
                  indent_style = "space",
                  indent_size = "2",
                },
              },
              -- -- make the language server recognize 'vim' global
              -- diagnostics = {
              --   globals = { "vim" },
              -- },
              -- workspace = {
              --   checkThirdParty = false,
              --   -- make language server aware of runtime files
              --   library = {
              --     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              --     [vim.fn.stdpath("config") .. "/lua"] = true,
              --   },
              -- },
            }
          }
        }
      },
    },
  },

}
