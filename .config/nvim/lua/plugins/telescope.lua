
return {

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      }
    },
    cmd = "Telescope",
    version = false,
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = '  ',
        entry_prefix = '   ',
        multi_icon = '   ',
        dynamic_preview_title = true,
        sorting_strategy = 'ascending',
        -- winblend = 20,
        layout_strategy = 'flex',
        layout_config = {
          prompt_position='top',
        },
        mappings = {
          i = {
            ['<c-h>'] = 'select_horizontal'
          },
        },
      },
      pickers = {
        buffers = {
          theme = 'dropdown',
          -- layout_strategy = 'center',
          previewer = false,
          ignore_current_buffer = true,
          sort_mru=true,
          sort_lastused = true,
          layout_config={
            anchor = 'N',
          },
          mappings = {
            i = {
              ['<c-x>'] = 'delete_buffer',
            },
            n = {
              x = 'delete_buffer',
            },
          },
        },
        colorscheme = {
          enable_preview = true,
          layout_strategy = 'vertical',
          layout_config = {
            anchor='SE',
            width=30,
            height=20,
            preview_height=1,
            prompt_position='bottom',
          }
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }
      }
    },
    config = function (_,opts)
      require('telescope').setup(opts)
      require("telescope").load_extension("fzf")
    end,
    keys = {
      -- common
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>r", "<cmd>Telescope oldfiles theme=dropdown<cr>", desc = "Find Recent" },
      -- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git-files" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      -- search
      { '<leader>"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>*", "<cmd>Telescope grep_string<cr>", desc = "Grep Word under cursor" },
      { "<leader>?", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme with preview", },
    },
  },
}
