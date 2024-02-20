return {
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<leader>gc", "<cmd>G commit<cr>" }
    }
  },
  {
    "tpope/vim-rhubarb",
    dependencies = "tpope/vim-fugitive",
    cmd = "GBrowse"
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
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
        remap = true,
      },
      -- { "<leader>gc", function() require("neogit.popups.commit.actions").commit() end, desc = "Neogit Commit" },
      -- { "<leader>gc", ":Neogit commit<cr>c", desc = "Neogit Commit" },
      -- { "<leader>gc", "<leader>ggcc", desc = "Neogit Commit" },
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
      { "]h",          "<cmd>Gitsigns next_hunk<cr>",                                        desc = "Next Git Hunk",           buffer = 0 },
      { "[h",          "<cmd>Gitsigns prev_hunk<cr>",                                        desc = "Previous Git Hunk",       buffer = 0 },
      -- Text Object
      { "ih",          "<cmd>Gitsigns select_hunk<cr>",                                      desc = "Previous Git Hunk",       buffer = 0, mode = { "o", "x" } },
      { "ah",          "<cmd>Gitsigns select_hunk<cr>",                                      desc = "Previous Git Hunk",       buffer = 0, mode = { "o", "x" } },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
    -- config = function(_, opts)
    --   require("gitsigns").setup(opts)
    --   vim.keymap.set("n", "q", function() return vim.wo.diff and "<cmd>wincmd h | q<cr>" or "q" end, {})
    -- end
  },
}
