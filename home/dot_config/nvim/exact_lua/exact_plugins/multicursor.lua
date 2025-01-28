return {

  {
    "jake-stewart/multicursor.nvim",
    -- enabled = false,
    branch = "1.0",
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
