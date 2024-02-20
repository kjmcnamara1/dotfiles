return {
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    -- keys = {
    --   { "<leader>gc", "<cmd>G commit<cr>" }
    -- }
  },
  {
    "tpope/vim-rhubarb",
    dependencies = "tpope/vim-fugitive",
    cmd = "GBrowse"
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      {
        "sindrets/diffview.nvim",
        keys = {
          { "<leader>gG", "<cmd>DiffviewOpen<cr>", desc = "Open Git Diffs" },
        },
      },
    },
    cmd = "Neogit",
    keys = {
      {
        "<leader>gg",
        function()
          local ng = require("neogit")
          if ng.status.status_buffer then
            ng.close()
          else
            ng.open()
          end
        end,
        desc = "Toggle NeoGit Status",
      },
      { "<leader>gc", function() require("neogit").action("commit", "commit", {})() end, desc = "Neogit Commit" },
    },
    opts = {
      kind             = "split",
      disable_hint     = true,
      graph_style      = "unicode",
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      signs            = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
        hunk = { "", "" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>",                                     desc = "Git Preview Hunk",               buffer = 0 },
      { "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>",                              desc = "Git Preview Hunk Inline",        buffer = 0 },
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>",                        desc = "Toggle Git Blame",               buffer = 0 },
      { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>",                                 desc = "Toggle Git Word Diff",           buffer = 0 },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>",                                     desc = "Git Stage Buffer",               buffer = 0 },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>",                                     desc = "Git Reset Buffer",               buffer = 0 },
      { "<leader>gd", "<cmd>Gitsigns diffthis<cr>",                                         desc = "Git Diff Current File to Index", buffer = 0 },
      { "<leader>gD", "<cmd>Gitsigns diffthis ~<cr>",                                       desc = "Git Diff Current File to HEAD",  buffer = 0 },
      { "q",          function() return vim.wo.diff and "<cmd>wincmd h | q<cr>" or "q" end, desc = "Close Git Diff",                 buffer = 0, expr = true, },
      -- Git Hunks
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",                                       desc = "Stage Git Hunk",                 buffer = 0 },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>",                                       desc = "Reset Git Hunk",                 buffer = 0 },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>",                                  desc = "Undo Stage Git Hunk",            buffer = 0 },
      -- Movements
      { "]h",         "<cmd>Gitsigns next_hunk<cr>",                                        desc = "Next Git Hunk",                  buffer = 0 },
      { "[h",         "<cmd>Gitsigns prev_hunk<cr>",                                        desc = "Previous Git Hunk",              buffer = 0 },
      -- Text Object (need :<c-u> instead of <cmd> to select entire hunk)
      { "ih",         ":<c-u>Gitsigns select_hunk<cr>",                                     desc = "Inside Git Hunk",                buffer = 0, mode = { "o", "x" } },
      { "ah",         ":<c-u>Gitsigns select_hunk<cr>",                                     desc = "Around Git Hunk",                buffer = 0, mode = { "o", "x" } },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },
}
