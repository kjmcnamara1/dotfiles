vim.api.nvim_create_autocmd('FileType', {
  desc = "Custom Lua Settings",
  group = vim.api.nvim_create_augroup('CustomLua', { clear = true }),
  pattern = 'lua',
  callback = function()
    vim.opt.formatoptions:remove('o')
  end
})

return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              -- inlay hints
              hint = {
                enable = true,
                arrayIndex = "Disable",
              },
              format = {
                defaultConfig = {
                  quote_style = "double",
                  indent_style = "space",
                  indent_size = 2,
                  max_lin_length = 120,
                  trailing_table_separator = "smart",
                },
              },
            }
          }
        }
      },
    },
  },

  {
    "folke/lazydev.nvim",
    dependencies = {
      "justinsgithub/wezterm-types",
    },
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        vim.fn.stdpath("config") .. "/lua",
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "wezterm-types",      mods = { "wezterm" } },
      },
    },
  },

  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority
            score_offset = 100,
          },
        },
      },
    },
  },

  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = {
      { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" },
    },
    opts = { snippet_engine = "luasnip" },
  }

}
