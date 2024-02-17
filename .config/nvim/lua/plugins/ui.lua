return {
  {
    -- Adds labels for marks to sign column and several keymaps
    "kshenoy/vim-signature",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    -- Change background highlight to match color of string, e.g. '#abf4c2'
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    -- Maximize window and restore
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<F3>", mode = { "i", "n", "v" }, desc = "Toggle maximize window" },
    },
  },
  {
    -- Status line
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    opts = {
      options = {
        globalstatus = true,
      },
    },
  },
  {
    -- Tab line
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.bufremove", -- Better algorithm for display after closing a buffer
    },
    keys = {
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>",                            desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>",                 desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>",                          desc = "Delete other buffers" },
      -- { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      -- { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer",              mode = { "n", "i", "v" } },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer",              mode = { "n", "i", "v" } },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer" },
      { "<c-x>",      function() require("mini.bufremove").delete(0, false) end, desc = "Quit Buffer",              mode = { "n", "i", "v" } },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        -- separator_style = 'slope',
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      -- "mrbjarksen/neo-tree-diagnostics.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
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

      -- Create autocmd to remove foldcolumn from symbols outline
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("symbols_nofold", { clear = true }),
        pattern = "Outline",
        callback = function()
          vim.opt.foldcolumn = "0"
        end
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        -- bottom_search = true,
        command_palette = true,
        -- long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    keys = {
      { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, desc = "Redirect Cmdline",   mode = "c", },
      { "<leader>nl", function() require("noice").cmd("last") end,                   desc = "Noice Last Message", },
      { "<leader>nh", function() require("noice").cmd("history") end,                desc = "Noice History", },
      { "<leader>na", function() require("noice").cmd("all") end,                    desc = "Noice All", },
      { "<leader>nd", function() require("noice").cmd("dismiss") end,                desc = "Dismiss All", },
      -- {
      --   "<c-f>",
      --   function()
      --     if not require("noice.lsp").scroll(4) then
      --       return "<c-f>"
      --     end
      --   end,
      --   silent = true,
      --   expr = true,
      --   desc = "Scroll forward",
      --   mode = { "i", "n", "s" },
      -- },
      -- {
      --   "<c-b>",
      --   function()
      --     if not require("noice.lsp").scroll(-4) then
      --       return "<c-b>"
      --     end
      --   end,
      --   silent = true,
      --   expr = true,
      --   desc = "Scroll backward",
      --   mode = { "i", "n", "s" },
      -- },
    },
    dependencies = {
      "rcarriga/nvim-notify",
      -- keys = {
      --   {
      --     "<leader>un",
      --     function()
      --       require("notify").dismiss({ silent = true, pending = true })
      --     end,
      --     desc = "Dismiss all Notifications",
      --   },
      -- },
      opts = {
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end,
      },
    },
  },
}
