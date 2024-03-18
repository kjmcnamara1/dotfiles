return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = not vim.g.vscode,
    dependencies = {
      "nushell/tree-sitter-nu",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo", "TSUpdateSync", "TSUpdate", },
    keys = {
      { ";", function() return require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_next() end,     mode = { "n", "x", "o" }, desc = "Repeat next move" },
      { ",", function() return require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_previous() end, mode = { "n", "x", "o" }, desc = "Repeat previous move" },
      -- {'f',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_f() end, mode={'n','x','o'},desc='Find character forwards'},
      -- {'F',function() return require('nvim-treesitter.textobjects.repeatable_move').builtin_F() end, mode={'n','x','o'},desc='Find character backwards'},
      { "t", function() return require("nvim-treesitter.textobjects.repeatable_move").builtin_t() end,                 mode = { "n", "x", "o" }, desc = "Until character forwards" },
      { "T", function() return require("nvim-treesitter.textobjects.repeatable_move").builtin_T() end,                 mode = { "n", "x", "o" }, desc = "Until character backwards" },
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      autotag = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
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
    -- init=function(plugin)
    --   require("nvim-treesitter.query_predicates")
    -- end,
    -- config = function(_,opts)
    --   require('nvim-treesitter.configs').setup(opts)
    --   -- vim.opt.foldmethod=exp
    --   -- vim.opt.foldexpr=nvim_treesitter#foldexpr()

    --   -- local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')
    --   -- vim.keymap.set({'n','x','o'}, ';',ts_repeat_move.repeat_last_move_next)
    --   -- vim.keymap.set({'n','x','o'}, ';',ts_repeat_move.repeat_last_move_previous)

    --   -- vim.keymap.set({'n','x','o'}, 'f',ts_repeat_move.builtin_f)
    --   -- vim.keymap.set({'n','x','o'}, 'F',ts_repeat_move.builtin_F)
    --   -- vim.keymap.set({'n','x','o'}, 't',ts_repeat_move.builtin_t)
    --   -- vim.keymap.set({'n','x','o'}, 'T',ts_repeat_move.builtin_T)
    -- end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          -- o = ai.gen_spec.treesitter({
          --   a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          --   i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          -- }),
          ["="] = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }),
          m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
          C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,
        },
      }
    end,
  },
}
