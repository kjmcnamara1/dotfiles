-- ================================================================================
-- * Telescope
-- ================================================================================
-- TODO: Replace with FzfLua

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
      -- build = 'make',
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader><space>", "<cmd>Telescope resume<cr>",      desc = "Resume" },
    { "<leader>ff",      "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
    { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },
    { "<leader>fb",      "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
    { "<leader>fg",      "<cmd>Telescope live_grep<cr>",   desc = "Search in CWD" },
    { "<leader>sh",      "<cmd>Telescope help_tags<cr>",   desc = "Help Pages" },
    { "<leader>sH",      "<cmd>Telescope highlights<cr>",  desc = "Search Highlight Groups" },
    { "<leader>sk",      "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
    { "<leader>so",      "<cmd>Telescope vim_options<cr>", desc = "Options" },
  },
  opts = {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "   ",
      entry_prefix = "    ",
      multi_icon = "   ",
      dynamic_preview_title = true,
      file_ignore_patterns = { "^%.git/", "%.jpg$" },
      sorting_strategy = "ascending",
      -- winblend = 20,
      layout_strategy = "flex",
      layout_config = {
        prompt_position = "top",
      },
      mappings = {
        i = {
          ["<c-h>"] = false,
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["<c-l>"] = false,
          ["<esc>"] = "close",
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        -- theme = "dropdown",
      },
      live_grep = {
        additional_args = { "--hidden" },
      },
      oldfiles = {
        theme = "dropdown",
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
        ignore_current_buffer = true,
        sort_mru = true,
        sort_lastused = true,
        layout_config = {
          anchor = "N",
        },
        mappings = {
          i = {
            ["<a-c>"] = "delete_buffer",
          },
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
