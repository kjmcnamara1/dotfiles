return {
  {
    "hrsh7th/nvim-cmp", -- autocompletion plugin
    cond = not vim.g.vscode,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "Exafunction/codeium.nvim",            -- copilot alternative
      "hrsh7th/cmp-buffer",                  -- completion source for text in buffer
      "hrsh7th/cmp-path",                    -- completion source for file system paths
      "hrsh7th/cmp-cmdline",                 -- completion source for commandline
      "petertriho/cmp-git",                  -- Git commits, github/gitlab issues, merge/pull requests, mentions, etc.
      "mtoohey31/cmp-fish",                  -- fish shell
      "andersevenrud/cmp-tmux",              -- tmux
      "hrsh7th/cmp-nvim-lsp",                -- completion source for neovim builtin LSP client
      "hrsh7th/cmp-nvim-lsp-signature-help", -- signature help
      "saadparwaiz1/cmp_luasnip",            -- completion source for luasnip
      "L3MON4D3/LuaSnip",                    -- snippet engine
      "rafamadriz/friendly-snippets",        -- useful snippets
      "onsails/lspkind.nvim",                -- vs-code like pictograms
      "windwp/nvim-autopairs",               -- auto-close brackets and functions
      "chrisgrieser/cmp-nerdfont",           -- nerd font icons
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        -- configure how nvim-cmp interacts with snippet engine
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end),
          ["<c-i>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "codeium",                group_index = 1, priority = 100, }, -- ai autocompletion
          { name = "nvim_lsp" },                                                 -- lsp
          { name = "nvim_lsp_signature_help" },                                  -- lsp signature
          { name = "luasnip" },                                                  -- snippets
          { name = "buffer" },                                                   -- text within current buffer
          { name = "path" },                                                     -- file system paths
          { name = "nerdfont" },                                                 -- nerd font icons
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = { Codeium = "", },
          }),
        },
        experimental = {
          ghost_text = true,
        },
      })

      cmp.setup.filetype("norg", {
        sources = {
          { name = "neorg" },
          { name = "codeium", group_index = 1, priority = 100, },
          { name = "buffer" },
          { name = "path" },
          { name = "nerdfont" },
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = {
          { name = "git" },
          { name = "buffer" },
          { name = "path" },
        },
      })

      cmp.setup.filetype("tmux", {
        sources = {
          { name = "tmux" },
          { name = "buffer" },
          { name = "path" },
        }
      })

      cmp.setup.filetype("fish", {
        sources = {
          { name = "fish" },
          { name = "buffer" },
          { name = "path" },
        }
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "path" },
          { name = "cmdline" },
        }
      })

      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
  {
    "windwp/nvim-autopairs", -- alternative option = 'cohama/lexima.vim'
    cond = not vim.g.vscode,
    lazy = true,
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        java = false,
      },
    },
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = { "nvim-lua/plenary.nvim", },
    cmd = "Codeium",
    build = ":Codeium Auth",
    opts = {},
  },
}
