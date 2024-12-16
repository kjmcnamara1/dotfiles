return {
  {
    "echasnovski/mini.files",
    cond = not vim.g.vscode,
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "-", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, desc = "Mini File Browser Current File" },
      { "_", function() require("mini.files").open(vim.fn.getcwd()) end,              desc = "Mini File Browser CWD" },
    },
    opts = {
      content = {
        filter = function(fs_entry)
          return fs_entry.name ~= ".git"
        end
      },
      windows = {
        preview = true,
      },
      mappings = {
        reveal_cwd = "_",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id
          vim.api.nvim_win_set_config(win_id, { border = "rounded" })
        end,
      })
    end
  },
  {
    "stevearc/oil.nvim",
    enabled = false,
    cond = not vim.g.vscode,
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "Oil",
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Oil File Browser" },
    },
    opts = {
      experimental_watch_for_changes = true,
      view_options = {
        show_hidden = true,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    cond = not vim.g.vscode,
    branch = "v3.x",
    dependencies = {
      -- "mrbjarksen/neo-tree-diagnostics.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e",  "<cmd>Neotree toggle reveal<cr>",                   desc = "NeoTree Explorer",     silent = true },
      { "<leader>ge", "<cmd>Neotree toggle reveal source=git_status<cr>", desc = "NeoTree Git Explorer", silent = true },
      -- { "<leader>oe", "<cmd>Neotree toggle reveal source=document_symbols<cr>", desc = "NeoTree Symbols Outline", silent = true },
      { "<leader>be", "<cmd>Neotree toggle reveal source=buffers<cr>",    desc = "NeoTree Buffers",      silent = true },
      -- { "<leader>de", "<cmd>Neotree toggle reveal bottom source=diagnostics<cr>", desc = "NeoTree Diagnostics",  silent = true },
    },
    opts = {
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        "document_symbols",
        -- "diagnostics",
      },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["<tab>"] = "toggle_node",
          ["Z"] = "expand_all_nodes",
        },
      },
      filesystem = {
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
        window = {
          position = "left",
          fuzzy_finder_mappings = {
            ["<c-n>"] = "move_cursor_down",
            ["<c-p>"] = "move_cursor_up",
          },
        },
      },
      buffers = {
        show_unloaded = true,
      },
      document_symbols = {
        window = {
          position = "right",
        },
      },
      -- diagnostics = {
      --   auto_preview = true,
      -- },
    },
  },
  {
    "simrat39/symbols-outline.nvim",
    enabled = false,
    cond = not vim.g.vscode,
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    keys = { { "<leader>oe", "<cmd>SymbolsOutline<cr>", desc = "Toggle Symbols Outline" } },
    opts = {
      relative_width = false,
      width = 50,
      symbols = {
        File = { icon = " ", hl = "@text.uri" },
        Module = { icon = " ", hl = "@namespace" },
        Namespace = { icon = "󰦮 ", hl = "@namespace" },
        Package = { icon = " ", hl = "@namespace" },
        Class = { icon = " ", hl = "@type" },
        Method = { icon = "󰊕 ", hl = "@method" },
        Property = { icon = " ", hl = "@method" },
        Field = { icon = " ", hl = "@field" },
        Constructor = { icon = " ", hl = "@constructor" },
        Enum = { icon = " ", hl = "@type" },
        Interface = { icon = " ", hl = "@type" },
        Function = { icon = "󰊕 ", hl = "@function" },
        Variable = { icon = "󰀫 ", hl = "@constant" },
        Constant = { icon = "󰏿 ", hl = "@constant" },
        String = { icon = " ", hl = "@string" },
        Number = { icon = "󰎠 ", hl = "@number" },
        Boolean = { icon = "󰨙 ", hl = "@boolean" },
        Array = { icon = " ", hl = "@constant" },
        Object = { icon = " ", hl = "@type" },
        Key = { icon = " ", hl = "@type" },
        Null = { icon = " ", hl = "@type" },
        EnumMember = { icon = " ", hl = "@field" },
        Struct = { icon = "󰆼 ", hl = "@type" },
        Event = { icon = " ", hl = "@type" },
        Operator = { icon = " ", hl = "@operator" },
        TypeParameter = { icon = " ", hl = "@parameter" },
        Component = { icon = " ", hl = "@function" },
        Fragment = { icon = " ", hl = "@constant" },
      },
    },
    config = function(_, opts)
      require("symbols-outline").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        desc = "Remove foldcolumn from symbols outline",
        group = vim.api.nvim_create_augroup("symbols_nofold", { clear = true }),
        pattern = "Outline",
        callback = function()
          vim.wo.foldcolumn = "0"
        end
      })
    end,
  }
}
