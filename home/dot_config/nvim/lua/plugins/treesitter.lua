-- ================================================================================
-- * TreeSitter
-- ================================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "windwp/nvim-ts-autotag",
    },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    version = false,             -- last release is way too old and doesn't work on Windows
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdateSync", "TSUpdate", },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      -- autotag = { enable = true },
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
            ["]A"] = "@assignment.inner",
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
            ["[A"] = "@assignment.inner",
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
            ["<leader>xna"] = "@parameter.inner",
            ["<leader>xnm"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>xpa"] = "@parameter.inner",
            ["<leader>xpm"] = "@function.outer",
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
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

}
