return {
  {
    "tpope/vim-fugitive",
    enabled = false,
    cond = not vim.g.vscode,
    cmd = { "G", "Git" },
    -- keys = {
    --   { "<leader>gc", "<cmd>G commit<cr>" }
    -- }
  },
  {
    "tpope/vim-rhubarb",
    enabled = false,
    cond = not vim.g.vscode,
    dependencies = "tpope/vim-fugitive",
    cmd = "GBrowse"
  },
  {
    "NeogitOrg/neogit",
    cond = not vim.g.vscode,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      {
        -- need to add keymap for closing Diffview
        "sindrets/diffview.nvim",
        keys = {
          { "<leader>gd", "<cmd>DiffviewOpen -- %<cr><cmd>DiffviewToggleFiles<cr>", desc = "Open Git Diffview" },
          { "<leader>gD", "<cmd>DiffviewOpen<cr>",                                  desc = "Open Git Diffview" },
          { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",                         desc = "Open Git Current History" },
          { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",                           desc = "Open Git File History" },
        },
        opts = {
          hooks = {
            view_opened = function()
              vim.g.in_diffview = true
            end,
            view_closed = function()
              vim.g.in_diffview = false
            end,
          },
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
      {
        "<leader>gc",
        function()
          require("neogit").action("commit", "commit", {})()
        end,
        desc = "Git Commit",
      },
      {
        -- BUG: Need to fix
        "<leader>gp",
        function()
          require("neogit").action("pull", "from_upstream")()
        end,
        desc = "Git Pull",
      },
      {
        "<leader>gP",
        function()
          require("neogit").action("push", "to_pushremote")()
        end,
        desc = "Git Push",
      },
    },
    opts = {
      -- kind             = "replace",
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
    cond = not vim.g.vscode,
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    keys = {
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",        buffer = 0 },
      { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>",          desc = "Toggle Git Word Diff",    buffer = 0 },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>",              desc = "Git Stage Buffer",        buffer = 0 },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>",              desc = "Git Reset Buffer",        buffer = 0 },
      -- { "<leader>gdi", "<cmd>Gitsigns diffthis<cr>",                  desc = "Git Diff Current File to Index", buffer = 0 },
      -- { "<leader>gdh", "<cmd>Gitsigns diffthis ~<cr>",                desc = "Git Diff Current File to HEAD",  buffer = 0 },
      -- Git Hunks
      { "<leader>hi", "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Preview Git Hunk Inline", buffer = 0 },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Git Hunk",        buffer = 0 },
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",                desc = "Stage Git Hunk",          buffer = 0 },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>",                desc = "Reset Git Hunk",          buffer = 0 },
      { "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<cr>",           desc = "Undo Stage Git Hunk",     buffer = 0 },
      -- Movements
      { "]h",         "<cmd>Gitsigns next_hunk<cr>",                 desc = "Next Git Hunk",           buffer = 0 },
      { "[h",         "<cmd>Gitsigns prev_hunk<cr>",                 desc = "Previous Git Hunk",       buffer = 0 },
      -- Text Object (need :<c-u> instead of <cmd> to select entire hunk)
      { "ih",         ":<c-u>Gitsigns select_hunk<cr>",              desc = "Inside Git Hunk",         buffer = 0, mode = { "o", "x" } },
      { "ah",         ":<c-u>Gitsigns select_hunk<cr>",              desc = "Around Git Hunk",         buffer = 0, mode = { "o", "x" } },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },
}
