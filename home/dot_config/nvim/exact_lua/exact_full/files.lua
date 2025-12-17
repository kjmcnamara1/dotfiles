return {

  {
    "echasnovski/mini.files",
    keys = {
      { "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "mini.files browser (current file)" },
      { "<leader>fM", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "mini.files (cwd)" },
    },
    opts = {
      windows = {
        preview = true,
        width_focus = 40,
        width_preview = 30,
      },
      mappings = {
        close = "<esc>",
        synchronize = "<cr>",
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end
  },

  {
    "mikavilpas/yazi.nvim",
    dependencies = "folke/snacks.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>",        desc = "Open yazi at the current file",         mode = { 'n', 'v' }, },
      { "<leader>fY", "<cmd>Yazi cwd<cr>",    desc = "Open yazi in nvim's working directory", },
      { "<leader>y",  "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
    },
    opts = {
      -- open_multiple_tabs = true,
      -- floating_window_scaling_factor = 0.5,
      yazi_floating_window_border = 'none',
      keymaps = {
        show_help = '<f1>',
      },
    },
  }

}
