
return {

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = 'Neogit',
    keys = {
      {'<leader>gg','<cmd>Neogit<cr>',desc = 'Open NeoGit'}
    },
    opts = {
      graph_style  ='unicode',
      telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
      end,
      signs = {
        -- { CLOSED, OPENED }
        section = { "󰧚", "󰧗" },
        item = { "󰬪", "󰬧" },
        hunk = { "󰅂", "󰅀" },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Git Preview Hunk" ,buffer=0},
      { "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", desc = "Git Preview Hunk Inline" ,buffer=0},
      { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",buffer=0 },
      { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Git Stage Buffer",buffer=0 },
      { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Git Reset Buffer",buffer=0 },
      -- Git Hunks
      { "<leader>ghs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage Git Hunk",buffer=0 },
      { "<leader>ghr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Git Hunk",buffer=0 },
      { "<leader>ghu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo Stage Git Hunk",buffer=0 },
      -- Movements
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Git Hunk",buffer=0 },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Git Hunk",buffer=0 },
      -- Text Object
      { "ih", ":<c-u>Gitsigns select_hunk<cr>", mode={'o','x'},desc = "Previous Git Hunk",buffer=0 },
      { "ah", ":<c-u>Gitsigns select_hunk<cr>", mode={'o','x'},desc = "Previous Git Hunk",buffer=0 },
    },
  },
}
