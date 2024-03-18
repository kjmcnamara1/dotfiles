return {
  {
    "nvim-telescope/telescope-symbols.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>sy", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
      { "<a-i>",      "<cmd>Telescope symbols<cr>", desc = "Symbols", mode = "i" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    tag = "0.1.5",
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      }
    },
    cmd = "Telescope",
    keys = {
      { "<leader><space>", "<cmd>Telescope resume<cr>",                    desc = "Resume" },
      -- LSP
      { "<leader>o",       "<cmd>Telescope lsp_document_symbols<cr>",      desc = "LSP Document Symbols",    buffer = 0 },
      { "gi",              "<cmd>Telescope lsp_implementations<cr>",       desc = "LSP Implementations",     buffer = 0 },
      -- { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "LSP Definition",              buffer = 0 },
      -- { "gr",         "<cmd>Telescope lsp_references<cr>",       desc = "LSP References",              buffer = 0 },
      -- { "gt",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP Type Definitions",        buffer = 0 },
      -- git
      { "<leader>gs",      "<cmd>Telescope git_status<cr>",                desc = "Git Status" },
      { "<leader>gC",      "<cmd>Telescope git_commits<cr>",               desc = "Git Commits" },
      { "<leader>gB",      "<cmd>Telescope git_branches<cr>",              desc = "Git Branches" },
      -- search
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<leader>,",       "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>/",       "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
      { "<leader>?",       "<cmd>Telescope live_grep<cr>",                 desc = "Search in CWD" },
      { "<leader>:",       "<cmd>Telescope command_history<cr>",           desc = "Command History" },
      { "<leader>r",       "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
      -- { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git-files" },
      { '<leader>"',       "<cmd>Telescope registers<cr>",                 desc = "Registers" },
      { "<leader>sa",      "<cmd>Telescope autocommands<cr>",              desc = "Auto Commands" },
      { "<leader>sc",      "<cmd>Telescope commands<cr>",                  desc = "Commands" },
      { "<leader>sn",      "<cmd>Telescope notify<cr>",                    desc = "Notifications" },
      { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",       desc = "Document diagnostics" },
      { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",               desc = "Workspace diagnostics" },
      { "<leader>*",       "<cmd>Telescope grep_string<cr>",               desc = "Search Word under cursor" },
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
      { "<leader>sH",      "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
      { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                 desc = "Man Pages" },
      { "<leader>sm",      "<cmd>Telescope marks<cr>",                     desc = "Jump to Mark" },
      { "<leader>so",      "<cmd>Telescope vim_options<cr>",               desc = "Options" },
      { "<leader>uC",      "<cmd>Telescope colorscheme<cr>",               desc = "Colorscheme with preview" },
      { "<leader>ft",      "<cmd>Telescope filetypes<cr>",                 desc = "Change FileType" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "   ",
        entry_prefix = "    ",
        multi_icon = "   ",
        dynamic_preview_title = true,
        hidden = true,
        sorting_strategy = "ascending",
        -- winblend = 20,
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        -- include hidden files in live_grep
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
        },
        mappings = {
          i = {
            ["<c-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<c-l>"] = false,
          },
          n = {
            ["<c-c>"] = "close",
          },
        },
      },
      pickers = {
        find_files = {
          -- include hidden files but not .git dir
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        oldfiles = {
          theme = "dropdown",
        },
        grep_string = {
          -- include hidden files but not .git dir
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        command_history = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          -- layout_strategy = 'center',
          previewer = false,
          ignore_current_buffer = true,
          sort_mru = true,
          sort_lastused = true,
          layout_config = {
            anchor = "N",
          },
          mappings = {
            i = {
              ["<c-x>"] = "delete_buffer",
            },
            n = {
              x = "delete_buffer",
            },
          },
        },
        colorscheme = {
          enable_preview = true,
          layout_strategy = "vertical",
          layout_config = {
            anchor = "SE",
            width = 30,
            height = 20,
            preview_height = 1,
            prompt_position = "bottom",
          }
        },
        filetypes = {
          layout_config = {
            anchor = "SE",
            width = 30,
            height = 10,
            prompt_position = "bottom",
          },
        },
        diagnostics = {
          theme = "ivy",
        },
        symbols = {
          theme = "cursor",
          layout_config = { width = 50 },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      }
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      if vim.fn.executable("make") == 1 then
        telescope.load_extension("fzf")
      end
    end,
  },
}
