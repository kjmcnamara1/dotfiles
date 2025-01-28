return {

  {
    "mg979/vim-visual-multi",
    enabled = false,
    -- cond = not vim.g.vscode,
    -- cmd = { "VMClear", "VMDebug", "VMFromSearch", "VMLive", "VMRegisters", "VMSearch", "VMTheme" },
    -- keys = {
    --   { "<c-n>",                    desc = "MultiCursor select word" },
    --   { "<c-down>",                 desc = "add MultiCursor above" },
    --   { "<c-up>",                   desc = "add MultiCursor below" },
    --   { "<s-left>",                 desc = "MultiCursor select left" },
    --   { "<s-right>",                desc = "MultiCursor select right" },
    --   { "<bslash><bslash><bslash>", desc = "add MultiCursor" },
    --   { "<bslash><bslash>gS",       desc = "reselect last MultiCursor selection" },
    --   { "<bslash><bslash>A",        desc = "MultiCursor select all words in file",            mode = { "n", "x" } },
    --   { "<bslash><bslash>/",        desc = "MultiCursor start regex search",                  mode = { "n", "x" } },
    --   { "<c-n>",                    desc = "MultiCursor select",                              mode = "x" },
    --   { "<bslash><bslash>a",        desc = "MultiCursor add visual selection",                mode = "x" },
    --   { "<bslash><bslash>f",        desc = "MultiCursor find all patterns from '/' register", mode = "x" },
    --   { "<bslash><bslash>c",        desc = "create column of MultiCursors",                   mode = "x" },
    -- },
    config = function()
      vim.cmd.VMTheme("nord")
    end,
    init = function()
      -- vim.g.VM_maps = vim.empty_dict()
      -- vim.g.VM_maps['Find Next'] = ')'
      -- vim.g.VM_maps['Find Prev'] = '('
      vim.cmd([[let g:VM_maps = {}]])
      vim.cmd([[let g:VM_maps['Find Next'] = ')']])
      vim.cmd([[let g:VM_maps['Find Prev'] = '(']])
    end
  },

  {
    "smoka7/multicursors.nvim",
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
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function is_active()
        local ok, hydra = pcall(require, 'hydra.statusline')
        return ok and hydra.is_active()
      end

      local function get_name()
        local ok, hydra = pcall(require, 'hydra.statusline')
        if ok then
          return hydra.get_name()
        end
        return ''
      end

      opts.lualine_b = vim.list_extend(opts.lualine_b or {}, {
        {
          get_name,
          cond = is_active,
          -- color = { fg = '#61afef', gui = 'bold' },
        },
      })
      dd(opts.lualine_b)
    end
  },

}
