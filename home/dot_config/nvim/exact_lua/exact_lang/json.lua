return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          -- Do not use jsonls's formatting capability, Use prettier instead
          init_options = { provideFormatter = false },
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
          -- BUG: can't disable 'Trailing comma' warning
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              local opd = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {})
              if string.match(result.uri, "%.jsonc$", -6) and result.diagnostics ~= nil then
                vim.print(err, result)
                local idx = 1
                while idx <= #result.diagnostics do
                  -- "Trailing comma"
                  if result.diagnostics[idx].code == 519 then
                    table.remove(result.diagnostics, idx)
                  else
                    idx = idx + 1
                  end
                end
              end
              opd(err, result, ctx, config)
            end,
          },
        },
        -- biome = {},
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
      }
    }
  },

  -- {
  --   "nvimtools/none-ls.nvim",
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.sources = vim.list_extend(opts.sources or {}, nls.builtins.formatting.biome)
  --   end
  -- },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

}
