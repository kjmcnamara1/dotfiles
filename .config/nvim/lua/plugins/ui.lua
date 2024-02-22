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
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",                            desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>",                 desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",                          desc = "Delete other buffers" },
      { "<leader>br", "<cmd>BufferLineMoveNext<cr>",                             desc = "Move buffer right" },
      { "<leader>bl", "<cmd>BufferLineMovePrev<cr>",                             desc = "Move buffer left" },
      { "<leader>bb", "<cmd>BufferLinePick<cr>",                                 desc = "Pick buffer" },
      { "<leader>bx", "<cmd>BufferLinePickClose<cr>",                            desc = "Pick buffer to close" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer",              mode = { "n", "i", "v", "c", "t" } },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer",              mode = { "n", "i", "v", "c", "t" } },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer" },
      { "<c-x>",      function() require("mini.bufremove").delete(0, false) end, desc = "Quit Buffer",              mode = { "n", "i", "v" } },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
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
    "stevearc/oil.nvim",
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
        bottom_search = true,
        command_palette = true,
        -- long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
    keys = {
      { "<c-d>",      "<cmd>NoiceDismiss<cr>", desc = "Dismiss All",        mode = { "i", "c", "t" } },
      { "<leader>ud", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All", },
      { "<leader>ul", "<cmd>NoiceLast<cr>",    desc = "Noice Last Message", },
      { "<leader>uh", "<cmd>NoiceHistory<cr>", desc = "Noice History", },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 1000,
          max_height = function()
            return math.floor(vim.o.lines * 0.25)
          end,
          max_width = function()
            return math.floor(vim.o.columns * 0.33)
          end,
          on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
          end,
          render = "wrapped-compact",
          -- stages = "static",
        },
        config = function(_, opts)
          local stages_util = require("notify.stages.util")
          opts.stages = {
            function(state)
              local next_height = state.message.height + 2
              local next_row = stages_util.available_slot(
                state.open_windows,
                next_height,
                stages_util.DIRECTION.BOTTOM_UP
              )
              if not next_row then
                return nil
              end
              return {
                relative = "editor",
                anchor = "NE",
                width = state.message.width,
                height = state.message.height,
                col = vim.opt.columns:get(),
                row = next_row,
                border = "rounded",
                style = "minimal",
                opacity = 0,
              }
            end,
            function()
              return {
                opacity = { 100 },
                col = { vim.opt.columns:get() },
              }
            end,
            function()
              return {
                col = { vim.opt.columns:get() },
                time = true,
              }
            end,
            function()
              return {
                width = {
                  1,
                  frequency = 2.5,
                  damping = 0.9,
                  complete = function(cur_width)
                    return cur_width < 3
                  end,
                },
                opacity = {
                  0,
                  frequency = 2,
                  complete = function(cur_opacity)
                    return cur_opacity <= 4
                  end,
                },
                col = { vim.opt.columns:get() },
              }
            end,
          }

          require("notify").setup(opts)
        end
      }
    },
  },
}
