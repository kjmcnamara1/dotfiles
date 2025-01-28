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

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip cursor above/below the main cursor.
      set({ "n", "v" }, "<up>",
        function() mc.lineAddCursor(-1) end)
      set({ "n", "v" }, "<down>",
        function() mc.lineAddCursor(1) end)
      set({ "n", "v" }, "<leader><up>",
        function() mc.lineSkipCursor(-1) end)
      set({ "n", "v" }, "<leader><down>",
        function() mc.lineSkipCursor(1) end)

      set({ "n", "v" }, "<leader>n",
        -- Add or skip adding a new cursor by matching word/selection
        function() mc.matchAddCursor(1) end)
      set({ "n", "v" }, "<leader>s",
        function() mc.matchSkipCursor(1) end)
      set({ "n", "v" }, "<leader>N",
        function() mc.matchAddCursor(-1) end)
      set({ "n", "v" }, "<leader>S",
        function() mc.matchSkipCursor(-1) end)

      -- Add all matches in the document
      set({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

      -- You can also add cursors with any motion you prefer:
      -- set("n", "<right>", function()
      --     mc.addCursor("w")
      -- end)
      -- set("n", "<leader><right>", function()
      --     mc.skipCursor("w")
      -- end)

      -- Rotate the main cursor.
      set({ "n", "v" }, "<left>", mc.nextCursor)
      set({ "n", "v" }, "<right>", mc.prevCursor)

      -- Delete the main cursor.
      set({ "n", "v" }, "<leader>x", mc.deleteCursor)

      -- Add and remove cursors with control + left click.
      set("n", "<c-leftmouse>", mc.handleMouse)

      -- Easy way to add and remove cursors using the main cursor.
      set({ "n", "v" }, "<c-q>", mc.toggleCursor)

      -- Clone every cursor and disable the originals.
      set({ "n", "v" }, "<leader><c-q>", mc.duplicateCursors)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- bring back cursors if you accidentally clear them
      set("n", "<leader>gv", mc.restoreCursors)

      -- Align cursor columns.
      set("n", "<leader>a", mc.alignCursors)

      -- Split visual selections by regex.
      set("v", "S", mc.splitCursors)

      -- Append/insert for each line of visual selections.
      set("v", "I", mc.insertVisual)
      set("v", "A", mc.appendVisual)

      -- match new cursors within visual selections by regex.
      set("v", "M", mc.matchCursors)

      -- Rotate visual selection contents.
      set("v", "<leader>t",
        function() mc.transposeCursors(1) end)
      set("v", "<leader>T",
        function() mc.transposeCursors(-1) end)

      -- Jumplist support
      set({ "v", "n" }, "<c-i>", mc.jumpForward)
      set({ "v", "n" }, "<c-o>", mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
    end
  },

}
