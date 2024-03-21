return {
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode,
    dependencies = {
      "folke/neodev.nvim",                   -- nvim config and plugin authoring
      "williamboman/mason-lspconfig.nvim",   -- automatically install LSPs
      "hrsh7th/cmp-nvim-lsp",                -- LSP completions
      "antosha417/nvim-lsp-file-operations", -- LSP rename for filenames
    },
    event = { "BufReadPre", "BufNewFile" },  -- with BufReadPost, lsp won't automatically attach to buffer
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
    keys = {
      { "K",          vim.lsp.buf.hover,          desc = "LSP Hover",                   buffer = 0 },
      { "<c-k>",      vim.lsp.buf.signature_help, desc = "LSP Signature Documentation", buffer = 0, mode = "i" },
      { "gD",         vim.lsp.buf.declaration,    desc = "LSP Declaration",             buffer = 0 },
      { "<leader>ca", vim.lsp.buf.code_action,    desc = "LSP Code Action",             buffer = 0, mode = { "n", "v" } },
      { "<leader>cf", vim.lsp.buf.format,         desc = "LSP Format",                  buffer = 0, mode = { "n", "v" } },
      { "<leader>ci", "<cmd>LspInfo<cr>",         desc = "LSP Info",                    buffer = 0 },
      -- { "<leader>rs", "<cmd>LspRestart<cr>",                     desc = "LSP Restart Server",          buffer = 0 }, -- conflicts with Telescope find_recent
      { "<leader>df", vim.diagnostic.open_float,  desc = "LSP Open Diagnostics",        buffer = 0 },
      { "]d",         vim.diagnostic.goto_next,   desc = "LSP Next Diagnostic",         buffer = 0 },
      { "[d",         vim.diagnostic.goto_prev,   desc = "LSP Previous Diagnostic",     buffer = 0 },
      -- { "<leader>q",  vim.diagnostic.setloclist,                 desc = "LSP Diagnostic SetLocList",   buffer = 0 },
      -- { "<leader>Q",  vim.diagnostic.setqflist,                  desc = "LSP Diagnostic SetQFList",    buffer = 0 },
      -- { '<leader>cr', vim.lsp.buf.rename, desc = 'LSP [r]e[n]ame' },
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Add folding capabilities for ufo plugin
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      -- Add rounded borders to hover and signature popups
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      -- Customize diagnostics
      vim.diagnostic.config({
        signs = {
          text = { "", "", "", "" },
          numhl = {
            "DiagnosticSignError",
            "DiagnosticSignWarn",
            "DiagnosticSignInfo",
            "DiagnosticSignHint",
          }
        },
        virtual_text = {
          source = "always",
          spacing = 4,
          prefix = function(diagnostic)
            local signs = { " ", " ", " ", "󰠠 " }
            return signs[diagnostic.severity] or "■"
          end,
        },
        float = {
          border = "rounded",
        },
        severity_sort = true,
      })

      require("mason-lspconfig").setup_handlers({
        function(ls)
          require("lspconfig")[ls].setup({
            capabilities = capabilities,
            handlers = handlers,
          })
        end,
        lua_ls = function()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            handlers = handlers,
            settings = { -- custom settings for lua
              Lua = {
                -- use double quotes
                format = {
                  defaultConfig = {
                    quote_style = "double",
                  },
                },
                -- make the language server recognize 'vim' global
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  -- make language server aware of runtime files
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                  },
                },
              },
            },
          })
        end,
      })

      -- Configure border for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    -- automatically install LSPs
    "williamboman/mason-lspconfig.nvim",
    cond = not vim.g.vscode,
    dependencies = "williamboman/mason.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    -- lazy = true,
    opts = {
      ensure_installed = {
        "lua_ls",
        "bashls",
        "pyright",  -- needed for rename
        "ruff_lsp", -- formatting, linting, and organize imports
        -- 'pylsp',
        -- 'jsonls',
        "biome",
        -- 'eslint',
        "marksman", -- markdown lsp
        "taplo",    -- TOML lsp
        -- 'yamlls' -- YAML lsp
      },
      -- handlers={},
      -- automatic_installation = true,
    },
  },
  {
    "folke/neodev.nvim",
    opts = {
      library = {
        plugins = {
          "nvim-dap-ui",
        },
        types = true,
      }
    },
  },
}
