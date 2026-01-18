-- ================================================================================
-- * TreeSitter
-- ================================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    -- lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    -- event = { "BufReadPre", "BufNewFile", "VeryLazy" },
    -- cmd = { "TSInstall", "TSUpdate", "TSContext", "TSInstallFromGrammar", "TSLog", "TSUninstall" },
  },

  {
    "mks-h/treesitter-autoinstall.nvim",
    opts = {
      ignore = {
        "sh",
        "snacks_notif",
        "noice",
        "lazy",
        "lazyjj",
        "jjui",
        "blink-cmp-menu",
        "snacks_win",
        "snacks_win_backdrop",
        "snacks_notif_history",
        "snacks_picker_input",
        "snacks_picker_list",
        "snacks_picker_preview",
        "snacks_layout_box",
        "snacks_terminal",
        "yazi",
        "flash_prompt",
        "minifiles",
        "lazy_backdrop",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        set_jumps = true,
      },
    },
    keys = {
      {
        "]z",
        function() require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds") end,
        desc = "Goto next fold",
      },
      {
        "[z",
        function() require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds") end,
        desc = "Goto previous fold",
      },
      {
        "<leader>xna",
        function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
        desc = "Swap with next argument",
      },
      {
        "<leader>xpa",
        function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end,
        desc = "Swap with previous argument",
      },
      {
        "<leader>xnm",
        function() require("nvim-treesitter-textobjects.swap").swap_next("@function.outer") end,
        desc = "Swap with next method",
      },
      {
        "<leader>xpm",
        function() require("nvim-treesitter-textobjects.swap").swap_previous("@function.outer") end,
        desc = "Swap with previous method",
      },
    }
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      max_lines = 5,
    },
  },

  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

}
