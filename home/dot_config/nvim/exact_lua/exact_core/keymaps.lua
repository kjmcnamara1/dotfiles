-- vim.keymap.set({ "n" }, "lhs", "rhs", { desc = "description", })

return {

  {
    "rmehri01/onenord.nvim",
    keys = {
      { "<c-q>",     "<cmd>qa<cr>",       desc = "Quit NeoVim" },
      { "U",         "<c-r>",             desc = "Redo" },
      { "<leader>m", "m",                 desc = "Mark" },
      { "mm",        "%",                 desc = "Matching bracket",            mode = { 'n', 'v', 'o' } },
      { "<esc>",     "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch",   mode = "i" },
      { "<c-v>",     "<c-r>+",            desc = "Paste from system clipboard", mode = "i" },
      { "<del>",     "<c-o>x",            desc = "Delete",                      mode = "i" },

      -- better indenting
      { "=",         "=gv",               mode = "v" },
      { "<",         "<gv",               mode = "v" },
      { ">",         ">gv",               mode = "v" },

      { "<leader>j", "J",                 desc = "Join Lines",                  mode = { 'n', 'v' } },
      -- { "<c-c>",     "cc<esc>",           desc = "Clear line" }, -- use mini.ai 'L' textobject
      { "<a-O>",     "O<esc>",            desc = "New line above" },
      { "<a-o>",     "o<esc>",            desc = "New line below" },
      {
        "<c-cr>",
        function()
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local count = math.max(vim.v.count, 1)
          for _ = 1, count do
            vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
          end
        end,
        desc = "Add blank line below",
        mode = { "n", "i", "v" },
      },
      {
        "<c-s-cr>",
        function()
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local count = math.max(vim.v.count, 1)
          for _ = 1, count do
            vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
          end
        end,
        desc = "Add blank line above",
        mode = { "n", "i", "v" },
      },

      -- move cursor
      { "<a-h>",              "<left>",                      desc = "Cursor left",           mode = { "i", "t", "c" } },
      { "<a-l>",              "<right>",                     desc = "Cursor right",          mode = { "i", "t", "c" } },
      { "<a-j>",              "<down>",                      desc = "Cursor down",           mode = { "i", "t", "c" } },
      { "<a-k>",              "<up>",                        desc = "Cursor up",             mode = { "i", "t", "c" } },
      { "gh",                 "0",                           desc = "Beginning of Line",     mode = { 'n', 'v' } },
      { "gs",                 "^",                           desc = "Start of Line",         mode = { 'n', 'v' } },
      { "gl",                 "$",                           desc = "End of Line",           mode = { 'n', 'v' } },
      { "j",                  [[v:count == 0 ? 'gj' : 'j']], desc = "Move down visual line", mode = { "n", "x" },     expr = true },
      { "k",                  [[v:count == 0 ? 'gk' : 'k']], desc = "Move up visual line",   mode = { "n", "x" },     expr = true },

      -- Move Lines
      { "<a-j>",              "<cmd>m .+1<cr>==",            desc = "Move down" },
      { "<a-k>",              "<cmd>m .-2<cr>==",            desc = "Move up" },
      { "<a-j>",              ":m '>+1<cr>gv=gv",            desc = "Move down",             mode = { "v" } },
      { "<a-k>",              ":m '<-2<cr>gv=gv",            desc = "Move up",               mode = { "v" } },
      -- { "<a-j>",              "<esc><cmd>m .+1<cr>==gi",     desc = "Move down",             mode = { "i" } }, -- Clashes with move cursor
      -- { "<a-k>",              "<esc><cmd>m .-2<cr>==gi",     desc = "Move up",               mode = { "i" } }, -- Clashes with move cursor

      { "<leader>ui",         vim.show_pos,                  desc = "Inspect Pos" },
      { "<leader>ut",         "<cmd>InspectTree<cr>",        desc = "Inspect Tree" },
      { "<leader>L",          "<cmd>Lazy<cr>",               desc = "Lazy Plugin Manager" },
      { "<esc>",              "<cmd>close<cr>",              desc = "Close Lazy",            ft = "lazy" },

      -- tabs
      { "<leader><tab><tab>", "<cmd>tabnew<cr>",             desc = "New Tab" },
      { "<leader><tab>]",     "<cmd>tabnext<cr>",            desc = "Next Tab" },
      { "<leader><tab>[",     "<cmd>tabprevious<cr>",        desc = "Previous Tab" },
      { "<leader><tab>d",     "<cmd>tabclose<cr>",           desc = "Close Tab" },
      { "<leader><tab>o",     "<cmd>tabonly<cr>",            desc = "Close Other Tabs" },

      -- windows
      { "<leader>w",          "<c-w>",                       desc = "Windows" },
    },
  },

  -- -- TODO: helix keybinds for navigating treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   keys = {
  --     {
  --       '<a-o>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():parent())
  --       end,
  --       desc = 'Parent Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<a-n>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():next_sibling())
  --       end,
  --       desc = 'Next Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<a-p>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():prev_sibling())
  --       end,
  --       desc = 'Previous Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --   },
  -- },

}
