return {

  -- ================================================================================
  -- * ColorScheme
  -- ================================================================================
  {
    "rmehri01/onenord.nvim",
    lazy=false,
    name = "onenord",
    opts = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  },

  -- ================================================================================
  -- * BufferLine
  -- ================================================================================
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
      -- { "backdround/tabscope.nvim", config = true },
    },
    keys = {
      { "<leader>bb", "<cmd>BufferLinePick<cr>",                                 desc = "Pick buffer" },
      { "<leader>bx",  "<cmd>BufferLinePickClose<cr>",                            desc = "Pick buffer to close" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",                            desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>",                 desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",                          desc = "Delete other buffers" },
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",                             desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",                             desc = "Move buffer left" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",                            desc = "Prev buffer" },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",                            desc = "Next buffer" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        -- separator_style = "slant",
        -- separator_style = { "", "" },
        -- indicator = { style = "none" },
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
          Snacks.bufdelete(n)
          -- require("tabscope").remove_tab_buffer(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
          -- require("mini.bufremove").delete(n, false)
          -- require("tabscope").remove_tab_buffer(n)
        end,
      },
    },
  },

  -- ================================================================================
  -- * Snacks
  -- ================================================================================
  {
    "folke/snacks.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<a-c>", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-'>",      function() Snacks.terminal() end, desc = "Toggle Terminal", mode = {'n','i','t'} },
      -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
        end,
      })
    end,
  },

  -- ================================================================================
  -- * Telescope
  -- ================================================================================
  -- TODO: Configure Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Telescope",
    keys = {
      { "<leader><space>", "<cmd>Telescope resume<cr>",                    desc = "Resume" },
      { "<leader>ff",       "<cmd>Telescope find_files<cr>",                desc = "Find Files" },
      { "<leader>fr",       "<cmd>Telescope oldfiles<cr>",                  desc = "Recent Files" },
      { "<leader>fb",       "<cmd>Telescope buffers<cr>",                   desc = "Buffers" },
      { "<leader>fg",      "<cmd>Telescope live_grep<cr>",                 desc = "Search in CWD" },
      { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                 desc = "Help Pages" },
      { "<leader>sH",      "<cmd>Telescope highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                   desc = "Key Maps" },
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "   ",
        entry_prefix = "    ",
        multi_icon = "   ",
        dynamic_preview_title = true,
        file_ignore_patterns = {"^%.git/", "%.jpg$"},
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
    config = function(_,opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim', 
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
  },

  -- ================================================================================
  -- * TODO
  -- ================================================================================
  {
    "folke/todo-comments.nvim",
    cond = not vim.g.vscode,
    dependencies = "nvim-lua/plenary.nvim",
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      {"]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      {"[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    },
    opts = {
      keywords = {
        TODO = { color = "todo" },
      },
      colors = {
        todo = { "@comment.todo", "#FFFF00" },
      },
    },
  },

  -- ================================================================================
  -- * Trouble
  -- ================================================================================
  -- TODO: Configure Trouble
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)", },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)", },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)", },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)", },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)", },
    },
    opts = {},
  },

  -- ================================================================================
  -- *: Yazi
  -- ================================================================================
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>y.", "<cmd>Yazi<cr>", desc = "Open yazi at the current file", },
      { "<leader>yc", "<cmd>Yazi cwd<cr>", desc = "Open yazi in nvim's working directory" , },
      { '<leader>yy', "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      open_multiple_tabs = true,
      floating_window_scaling_factor = 0.75,
      -- yazi_floating_window_border = 'none',
      -- keymaps = {
      --   show_help = '<f1>',
      -- },
    },
  },

  -- ================================================================================
  -- *: Which Key
  -- ================================================================================
  {
    "folke/which-key.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    keys = { { "<leader>?", function() require("which-key").show() end, desc = "Keymaps (which-key)" } },
    opts = { preset = "helix" },
  },

  -- ================================================================================
  -- * Zen Mode
  -- ================================================================================
  {
    -- Distraction free interface
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode", mode = { "n", "v" } }
    },
    opts = {
      window = {
        options = {
          -- signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
          scrolloff = 999,
        }
      },
      plugins = {
        options = {
          enabled = true,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        wezterm = { enabled = true, font = "+2" },
      },
    }
  }

}
