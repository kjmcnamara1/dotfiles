return {
  {
    "akinsho/toggleterm.nvim",
    cond = not vim.g.vscode,
    cmd = "ToggleTerm",
    keys = {
      {
        "<c-t>",
        -- "<cmd>ToggleTerm<cr>",
        mode = { "n", "t" },
        desc = "Toggle Terminal",
      },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Toggle Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Terminal", },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Toggle Vertical Terminal", },
      { "<leader>tt", "<cmd>ToggleTerm direction=tab<cr>",        desc = "Toggle Tab Terminal" },
      { "<c-n>",      [[<c-\><c-n>]],                             desc = "Normal Mode",                mode = "t", buffer = 0 },
    },
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-t>]],
      direction = "float",
      -- winbar = {
      --   enabled = true,
      -- },
      float_opts = {
        border = "curved",
        width = math.floor(vim.o.columns * .8),
        height = math.floor(vim.o.lines * .6),
      },
      -- size = function(term)
      --   if term.direction == "horizontal" then
      --     return math.max(math.floor(vim.o.lines * .3), 10)
      --   elseif term.direction == "vertical" then
      --     return math.max(math.floor(vim.o.columns * 0.4), 40)
      --   else
      --     return 20
      --   end
      -- end,
    },
  },
  {
    "willothy/flatten.nvim",
    -- enabled = false,
    cond = not vim.g.vscode,
    ft = "toggleterm",
    opts = {
      window = {
        open = "alternate",
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
