return {

  {
    "rmehri01/onenord.nvim",
    keys = {
      { "<c-q>",      "<cmd>qa<cr>",       desc = "Quit NeoVim" },
      { "U",          "<c-r>",             desc = "Redo" },
      -- { ",",          ";",           desc = "Repeat Character Movement Forward" },
      -- { ";",          ",",           desc = "Repeat Character Movement Backward" },
      { "<leader>j",  "J",                 desc = "Join Lines" },
      { "<a-O>",      "O<esc>",            desc = "Put empty line above" },
      { "<a-o>",      "o<esc>",            desc = "Put empty line below" },
      { "<a-i>",      "^",                 desc = "Start of Line" },
      { "<a-a>",      "$",                 desc = "End of Line" },
      { "<leader>ui", vim.show_pos,        desc = "Inspect Pos" },
      { "<esc>",      "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch", mode = { "i", "n" }, }
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      { "s",     function() require("flash").jump() end,              desc = "Flash",               mode = { "n", "x", "o" } },
      { "S",     function() require("flash").treesitter() end,        desc = "Flash Trweesitter",   mode = { "n", "x", "o" } },
      { "r",     function() require("flash").remote() end,            desc = "Remote Flash",        mode = "o" },
      { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",   mode = { "o", "x" } },
      { "<c-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search", mode = { "c" } },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>ff",      "<cmd>FzfLua files<cr>",                                    desc = "Find Files" },
      { "<leader><space>", "<cmd>FzfLua resume<cr>",                                   desc = "Fzf Resume" },
      { "<leader>,",       "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Fzf Buffers" },
      { "<leader>fH",      "<cmd>FzfLua highlights<cr>",                               desc = "Fzf Highlights" },
    },
  },

  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<a-c>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
      { "<c-'>",      function() Snacks.terminal() end,                desc = "Toggle Terminal",             mode = { 'n', 'i', 't' } },
      -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
      -- { "<leader>dps", function() Snacks.profiler.scratch() end,        desc = "Profiler Scratch Bufer" },
    },
  },

  {
    "lambdalisue/vim-suda",
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

  {
    "saifulapm/commasemi.nvim",
    keys = {
      { "<localleader>,", desc = "Toggle , at End of Line" },
      { "<localleader>;", desc = "Toggle ; at End of Line" },
    }
  },

  {
    "folke/persistence.nvim",
    keys = {
      { "<leader>ss", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      {
        "<c-s-q>",
        function()
          require("persistence").stop(); vim.cmd([[:qa]])
        end,
        desc = "Quit Neovim without saving session"
      },
    },
  },

  {
    "mrjones2014/smart-splits.nvim",
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
  },

  {
    "mikavilpas/yazi.nvim",
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>",        desc = "Open yazi at the current file", },
      { "<leader>fY", "<cmd>Yazi cwd<cr>",    desc = "Open yazi in nvim's working directory", },
      { '<leader>y',  "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
    },
  },

  {
    "folke/which-key.nvim",
    keys = {
      { "<leader>?", function() require("which-key").show() end,                   desc = "Keymaps (which-key)" },
      { "g?",        function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)" },
    },
  },

}
