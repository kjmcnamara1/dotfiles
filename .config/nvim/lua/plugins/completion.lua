return {
  {
    "hrsh7th/nvim-cmp",
    event = 'InsertEnter',
    dependencies = {
      "hrsh7th/cmp-buffer",           -- source for text in buffer
      "hrsh7th/cmp-path",             -- source for file system paths
      'hrsh7th/cmp-cmdline',          -- source for commandline
      "hrsh7th/cmp-nvim-lsp",         -- source for neovim builtin LSP client
      "L3MON4D3/LuaSnip",             -- snippet engine
      "saadparwaiz1/cmp_luasnip",     -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim",         -- vs-code like pictograms
      "windwp/nvim-autopairs",        -- auto-close brackets and functions
    },
    config = function(_, opts)
      local cmp = require("cmp")

      require("luasnip.loaders.from_vscode").lazy_load()



      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        -- configure how nvim-cmp interacts with snippet engine
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),            -- show completion suggestions
          -- ["<C-Space>"] = function(fallback)
          --   if cmp.visible() then
          --     if cmp.visible_docs() then
          --       cmp.close_docs()
          --     else
          --       cmp.open_docs()
          --     end
          --   else
          --     cmp.complete()
          --   end
          -- end,
          ["<C-x>"] = cmp.mapping.abort(),                   -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" }, -- lsp
          { name = "luasnip" },  -- snippets
          { name = "buffer" },   -- text within current buffer
          { name = "path" },     -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = require('lspkind').cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
    end,
  },
  {
    "windwp/nvim-autopairs",
    lazy = true,
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      },
    },
  }
}
