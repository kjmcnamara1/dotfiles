return {

  -- ================================================================================
  -- * Navigation
  -- ================================================================================
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    keys = {
      { "<c-h>",   function() require("smart-splits").move_cursor_left() end },
      { "<c-j>",   function() require("smart-splits").move_cursor_down() end },
      { "<c-k>",   function() require("smart-splits").move_cursor_up() end },
      { "<c-l>",   function() require("smart-splits").move_cursor_right() end },
      { "<c-\\>",  function() require("smart-splits").move_cursor_previous() end },
      { "<c-a-h>", function() require("smart-splits").resize_left() end },
      { "<c-a-j>", function() require("smart-splits").resize_down() end },
      { "<c-a-k>", function() require("smart-splits").resize_up() end },
      { "<c-a-l>", function() require("smart-splits").resize_right() end },
      { "<c-w>R",  function() require("smart-splits").start_resize_mode() end },
      { "<c-s-h>", function() require("smart-splits").swap_buf_left() end },
      { "<c-s-j>", function() require("smart-splits").swap_buf_down() end },
      { "<c-s-k>", function() require("smart-splits").swap_buf_up() end },
      { "<c-s-l>", function() require("smart-splits").swap_buf_right() end },
    },
    opts = { default_amount = 3, at_edge = "stop", cursor_follows_swapped_bufs = true },
  },

  -- ================================================================================
  -- * Sudo Write
  -- ================================================================================
  {
    "lambdalisue/vim-suda",
    cmd = { "SudaRead", "SudaWrite" },
    keys = {
      {
        "<c-s>",
        function()
          local buf = vim.api.nvim_win_get_buf(0)
          if vim.bo[buf].readonly then
            vim.cmd.SudaWrite()
          else
            vim.cmd.write()
          end
        end,
        desc = "Save file",
        mode = { "i", "x", "n", "s" },
      },
    },
  },

  -- ================================================================================
  -- * TreeSitter
  -- ================================================================================
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdateSync", "TSUpdate", },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      autotag = { enable = true },
      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]c"] = "@comment.outer",
            ["]a"] = "@parameter.inner",
            ["]m"] = "@function.outer",
            ["]f"] = "@call.outer",
            ["]C"] = "@class.outer",
            ["]="] = "@assignment.inner",
            ["]l"] = "@loop.outer",
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            -- ["]z"] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            -- ["<tab>"] = {query={'@variable*','@attribute.inner*','@parameter.inner','@assignment.inner','@conditional.inner','@call.inner'}},
          },
          -- goto_next_end = {
          --   [']C'] = '@comment.outer',
          --   [']A'] = '@parameter.outer',
          --   ["]F"] = "@function.outer",
          --   ["]["] = "@class.outer"
          -- },
          goto_previous_start = {
            ["[c"] = "@comment.outer",
            ["[a"] = "@parameter.inner",
            ["[m"] = "@function.outer",
            ["[f"] = "@call.outer",
            ["[C"] = "@class.outer",
            ["[="] = "@assignment.inner",
            ["[l"] = "@loop.outer",
            ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
            -- ["[z"] = { query = '@fold', query_group = 'folds', desc = 'Previous fold' },
            -- ["<s-tab>"] = {query={'@variable*','@attribute.inner*','@parameter.inner','@assignment.inner','@conditional.inner','@call.inner'}},
          },
          -- goto_previous_end = {
          --   ['[C'] = '@comment.outer',
          --   ['[A'] = '@parameter.outer',
          --   ["[F"] = "@function.outer",
          --   ["[]"] = "@class.outer"
          -- },
          -- goto_next = {[']c'] = '@comment.outer'},
          -- goto_previous = {['[c'] = '@comment.outer'},
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner",
            ["<leader>nm"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>pa"] = "@parameter.inner",
            ["<leader>pm"] = "@function.outer",
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  }

}
