return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  keys = {
    { ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        require("gitsigns").nav_hunk('next')
      end
    end, "Next Hunk" },
    { '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        require("gitsigns").nav_hunk('prev')
      end
    end, "Previous Hunk" },
    { ']H',          '<cmd>Gitsigns nav_hunk last<cr>',             desc = 'Last Hunk',            buffer = 0 },
    { '[H',          '<cmd>Gitsigns nav_hunk first<cr>',            desc = 'First Hunk',           buffer = 0 },
    { "<leader>hs",  ":Gitsigns stage_hunk<cr>",                    desc = "Stage Hunk",           buffer = 0, mode = { 'n', 'v' } },
    { "<leader>hu",  ":Gitsigns undo_stage_hunk<cr>",               desc = "Undo Stage Hunk",      buffer = 0, mode = { 'n', 'v' } },
    { "<leader>hr",  ":Gitsigns reset_hunk<cr>",                    desc = "Reset Hunk",           buffer = 0, mode = { 'n', 'v' } },
    { "<leader>hS",  "<cmd>Gitsigns stage_buffer<cr>",              desc = "Stage Buffer",         buffer = 0 },
    { "<leader>hR",  "<cmd>Gitsigns reset_buffer<cr>",              desc = "Reset Buffer",         buffer = 0 },
    { "<leader>hp",  "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Hunk",         buffer = 0 },
    { "<leader>hi",  "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Preview Hunk Inline",  buffer = 0 },
    { "<leader>hb",  "<cmd>Gitsigns blame_line<cr>",                desc = "Blame Line",           buffer = 0 },
    { "<leader>ugB", "<cmd>Gitsigns blame<cr>",                     desc = "Blame Buffer",         buffer = 0 },
    { "<leader>ugb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",     buffer = 0 },
    { "<leader>ugw", "<cmd>Gitsigns toggle_word_diff<cr>",          desc = "Toggle Git Word Diff", buffer = 0 },
    -- { "<leader>ghd", "<cmd>Gitsigns diffthis<cr>",                  desc = "Diff This",            buffer = 0 },
    -- { "<leader>ghD", "<cmd>Gitsigns diffthis ~<cr>",                desc = "Diff This ~",          buffer = 0 },
    { 'ih',          ":<c-u>Gitsigns select_hunk<cr>",              desc = "inner hunk (git)",     buffer = 0, mode = { "o", "x" } },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
  },
}
