return {
  {
    "hrsh7th/nvim-cmp", -- autocompletion plugin
    cond = not vim.g.vscode,
    event = "InsertEnter",
    dependencies = {
      "Exafunction/codeium.nvim",     -- copilot alternative
      "hrsh7th/cmp-buffer",           -- completion source for text in buffer
      "hrsh7th/cmp-path",             -- completion source for file system paths
      "hrsh7th/cmp-cmdline",          -- completion source for commandline
      "hrsh7th/cmp-nvim-lsp",         -- completion source for neovim builtin LSP client
      "saadparwaiz1/cmp_luasnip",     -- completion source for autocompletion
      "L3MON4D3/LuaSnip",             -- snippet engine
      "rafamadriz/friendly-snippets", -- useful snippets
      "onsails/lspkind.nvim",         -- vs-code like pictograms
      "windwp/nvim-autopairs",        -- auto-close brackets and functions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

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
          -- ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping(
            function(fallback)
              if cmp.visible() then
                cmp.close()
              else
                cmp.complete()
              end
            end),
          -- ["<tab>"] = cmp.mapping(
          --   function(fallback)
          --     if cmp.visible() then
          --       cmp.select_next_item()
          --     elseif luasnip.expand_or_jumpable() then
          --       luasnip.expand_or_jump()
          --     elseif has_words_before() then
          --       cmp.complete()
          --     else
          --       fallback()
          --     end
          --   end,
          --   { "i", "s" }
          -- ),
          -- ["<s-tab>"] = cmp.mapping(
          --   function(fallback)
          --     if cmp.visible() then
          --       cmp.select_prev_item()
          --     elseif luasnip.jumpable(-1) then
          --       luasnip.jump(-1)
          --     else
          --       fallback()
          --     end
          --   end,
          --   { "i", "s" }
          -- ),
          -- ["<C-x>"] = cmp.mapping.abort(),                   -- close completion window
          ["<c-i>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "codeium", group_index = 1, priority = 100, }, -- ai autocompletion
          { name = "nvim_lsp" },                                  -- lsp
          { name = "luasnip" },                                   -- snippets
          { name = "buffer" },                                    -- text within current buffer
          { name = "path" },                                      -- file system paths
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = require("lspkind").cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })

      cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
    end,
  },
  {
    "windwp/nvim-autopairs",
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
