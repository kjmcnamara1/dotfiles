return {

  {
    "jake-stewart/multicursor.nvim",
    -- enabled = false,
    branch = "1.0",
    keys = function()
      local mc = require("multicursor-nvim")
      return {
        { "J",             function() mc.lineAddCursor(1) end,     desc = 'MultiCursor: Add cursor below',                       mode = { "n", "v" } },
        { "K",             function() mc.lineAddCursor(-1) end,    desc = 'MultiCursor: Add cursor above',                       mode = { "n", "v" } },
        { "<c-s-j>",       function() mc.lineSkipCursor(1) end,    desc = 'MultiCursor: Move main cursor below',                 mode = { "n", "v" } },
        { "<c-s-k>",       function() mc.lineSkipCursor(-1) end,   desc = 'MultiCursor: Move main cursor above',                 mode = { "n", "v" } },
        { "<c-n>",         function() mc.matchAddCursor(1) end,    desc = 'MultiCursor: Add cursor next cword/sel',              mode = { "n", "v" } },
        { "<c-p>",         function() mc.matchAddCursor(-1) end,   desc = 'MultiCursor: Add cursor previous cword/sel',          mode = { "n", "v" } },
        { "<a-c-n>",       function() mc.matchSkipCursor(1) end,   desc = 'MultiCursor: Move main cursor next cword/sel',        mode = { "n", "v" } },
        { "<a-c-p>",       function() mc.matchSkipCursor(-1) end,  desc = 'MultiCursor: Move main cursor previous cword/sel',    mode = { "n", "v" } },
        { "mcA",           mc.matchAllAddCursors,                  desc = 'MultiCursor: Add cursor to all cword/sel',            mode = { "n", "v" } },
        { "L",             function() mc.nextCursor(false) end,    desc = 'MultiCursor: Move main cursor to next selection',     mode = { "n", "v" } },
        { "H",             function() mc.prevCursor(false) end,    desc = 'MultiCursor: Move main cursor to previous selection', mode = { "n", "v" } },
        { "<c-s-l>",       mc.lastCursor,                          desc = 'MultiCursor: Move main cursor to last selection',     mode = { "n", "v" } },
        { "<c-s-h>",       mc.firstCursor,                         desc = 'MultiCursor: Move main cursor to first selection',    mode = { "n", "v" } },
        { "<c-i>",         mc.jumpForward,                         desc = 'MultiCursor: Jump forwards',                          mode = { "n", "v" } },
        { "<c-o>",         mc.jumpBackward,                        desc = 'MultiCursor: Jump backwards',                         mode = { "n", "v" } },
        { "<c-c>",         mc.deleteCursor,                        desc = 'MultiCursor: Delete main cursor' },
        { "mcx",           mc.deleteCursor,                        desc = 'MultiCursor: Delete main cursor',                     mode = { "n", "v" } },
        { "mcc",           mc.toggleCursor,                        desc = 'MultiCursor: Add/remove main cursor',                 mode = { "n", "v" } },
        { "mcd",           mc.duplicateCursors,                    desc = 'MultiCursor: Duplicate cursors',                      mode = { "n", "v" } },
        { "mcq",           mc.clearCursors,                        desc = 'MultiCursor: Clear cursors' },
        { "<c-leftmouse>", mc.handleMouse,                         desc = 'MultiCursor: Add/remove cursor' },
        { "<leader>gv",    mc.restoreCursors,                      desc = 'MultiCursor: Restore cursors' },
        { "&",             mc.alignCursors,                        desc = 'MultiCursor: Align cursors' },
        { "mca",           mc.alignCursors,                        desc = 'MultiCursor: Align cursors' },
        { "I",             mc.insertVisual,                        desc = 'MultiCursor: Insert before cursors',                  mode = "v" },
        { "A",             mc.appendVisual,                        desc = 'MultiCursor: Append after cursors',                   mode = "v" },
        { "S",             mc.splitCursors,                        desc = 'MultiCursor: Split cursors',                          mode = "v" },
        { "M",             mc.matchCursors,                        desc = 'MultiCursor: Match cursors',                          mode = "v" },
        { "mct",           function() mc.transposeCursors(1) end,  desc = 'MultiCursor: Transpose selections forwards',          mode = "v" },
        { "mcT",           function() mc.transposeCursors(-1) end, desc = 'MultiCursor: Transpose selections backwards',         mode = "v" },
        { "mcl",           function() mc.swapCursors(1) end,       desc = 'MultiCursor: Swap selection forwards',                mode = "v" },
        { "mch",           function() mc.swapCursors(-1) end,      desc = 'MultiCursor: Swap selection backwards',               mode = "v" },
        {
          "<esc>",
          function()
            if not mc.cursorsEnabled() then
              mc.enableCursors()
            elseif mc.hasCursors() then
              mc.clearCursors()
            else
              vim.cmd.noh()
            end
          end,
          desc = "MultiCursor:Escape and clear hlsearch",
        },
      }
    end,
    config = function()
      require("multicursor-nvim").setup()
      vim.api.nvim_set_hl(0, "MultiCursorCursor", { fg = "#7b8290", reverse = true })
    end
  },

  {
    "smoka7/multicursors.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
    opts = {
      mode_keys = {
        extend = 'v',
      },
      hint_config = {
        float_opts = {
          border = 'rounded',
        },
        position = 'bottom-right',
      },
      generate_hints = {
        config = {
          column_count = 1,
        },
      },
    },
    config = function(_, opts)
      require('multicursors').setup(opts)
    end
  },

  -- {
  --   "nvim-lualine/lualine.nvim",
  --   opts = function(_, opts)
  --     opts.sections.lualine_a = {
  --       {
  --         function()
  --           local ok, hydra = pcall(require, 'hydra.statusline')
  --           local mc_mode_map = {
  --             ['MC Normal'] = 'MC NRM',
  --             ['MC Insert'] = 'MC INS',
  --             ['MC Extend'] = 'MC EXT',
  --           }
  --           if ok and hydra.is_active() then
  --             local mc_mode = hydra.get_name()
  --             return mc_mode_map[mc_mode] or mc_mode
  --           else
  --             return require("lualine.utils.mode").get_mode()
  --           end
  --         end
  --       }
  --     }
  --   end
  -- },

}
