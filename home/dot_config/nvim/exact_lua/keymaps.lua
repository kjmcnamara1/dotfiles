return {

  {
    "rmehri01/onenord.nvim",
    keys = {
      { "<c-q>",     "<cmd>qa<cr>",       desc = "Quit NeoVim" },
      { "U",         "<c-r>",             desc = "Redo" },
      { "<leader>m", "m",                 desc = "Mark" },
      { "mm",        "%",                 desc = "Matching bracket",            mode = { 'n', 'v', 'o' } },
      { "<esc>",     "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch",   mode = "i" },
      { "<c-v>",     "<c-r>+",            desc = "Paste from system clipboard", mode = "i" },
      -- { "<del>",      "<c-o>x",            desc = "Delete",                    mode = "i" },

      -- better indenting
      { "=",         "=gv",               mode = "v" },
      { "<",         "<gv",               mode = "v" },
      { ">",         ">gv",               mode = "v" },

      { "<leader>j", "J",                 desc = "Join Lines" },
      -- { "<c-c>",     "cc<esc>",           desc = "Clear line" }, -- use mini.ai 'L' textobject
      { "<a-O>",     "O<esc>",            desc = "New line above" },
      { "<a-o>",     "o<esc>",            desc = "New line below" },
      {
        "<c-cr>",
        function()
          local line = vim.api.nvim_win_get_cursor(0)[1]
          local count = math.max(vim.v.count, 1)
          for _ = 1, count do
            vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
          end
        end,
        desc = "Add blank line below",
        mode = { "n", "i", "v" },
      },
      {
        "<c-s-cr>",
        function()
          local line = vim.api.nvim_win_get_cursor(0)[1] - 1
          local count = math.max(vim.v.count, 1)
          for _ = 1, count do
            vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
          end
        end,
        desc = "Add blank line above",
        mode = { "n", "i", "v" },
      },

      -- move cursor
      { "<a-h>",              "<left>",                      desc = "Cursor left",           mode = { "i", "t", "c" } },
      { "<a-l>",              "<right>",                     desc = "Cursor right",          mode = { "i", "t", "c" } },
      { "<a-j>",              "<down>",                      desc = "Cursor down",           mode = { "i", "t", "c" } },
      { "<a-k>",              "<up>",                        desc = "Cursor up",             mode = { "i", "t", "c" } },
      { "gh",                 "0",                           desc = "Beginning of Line",     mode = { 'n', 'v' } },
      { "gs",                 "^",                           desc = "Start of Line",         mode = { 'n', 'v' } },
      { "gl",                 "$",                           desc = "End of Line",           mode = { 'n', 'v' } },
      { "j",                  [[v:count == 0 ? 'gj' : 'j']], desc = "Move down visual line", mode = { "n", "x" },     expr = true },
      { "k",                  [[v:count == 0 ? 'gk' : 'k']], desc = "Move up visual line",   mode = { "n", "x" },     expr = true },

      -- Move Lines
      { "<a-j>",              "<cmd>m .+1<cr>==",            desc = "Move down" },
      { "<a-k>",              "<cmd>m .-2<cr>==",            desc = "Move up" },
      { "<a-j>",              "<esc><cmd>m .+1<cr>==gi",     desc = "Move down",             mode = { "i" } },
      { "<a-k>",              "<esc><cmd>m .-2<cr>==gi",     desc = "Move up",               mode = { "i" } },
      { "<a-j>",              ":m '>+1<cr>gv=gv",            desc = "Move down",             mode = { "v" } },
      { "<a-k>",              ":m '<-2<cr>gv=gv",            desc = "Move up",               mode = { "v" } },

      { "<leader>ui",         vim.show_pos,                  desc = "Inspect Pos" },
      { "<leader>ut",         "<cmd>InspectTree<cr>",        desc = "Inspect Tree" },
      { "<leader>L",          "<cmd>Lazy<cr>",               desc = "Lazy Plugin Manager" },
      { "<esc>",              "<cmd>close<cr>",              desc = "Close Lazy",            ft = "lazy" },

      -- tabs
      { "<leader><tab><tab>", "<cmd>tabnew<cr>",             desc = "New Tab" },
      { "<leader><tab>]",     "<cmd>tabnext<cr>",            desc = "Next Tab" },
      { "<leader><tab>[",     "<cmd>tabprevious<cr>",        desc = "Previous Tab" },
      { "<leader><tab>d",     "<cmd>tabclose<cr>",           desc = "Close Tab" },
      { "<leader><tab>o",     "<cmd>tabonly<cr>",            desc = "Close Other Tabs" },

      -- windows
      { "<leader>w",          "<c-w>",                       desc = "Windows" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>'",  "<cmd>e #<cr>",                            desc = "Alternate Buffer" },
      { "<leader>bn", "<cmd>enew<cr>",                           desc = "New file" },
      { "<leader>bb", "<cmd>BufferLinePick<cr>",                 desc = "Pick buffer" },
      { "<leader>bx", "<cmd>BufferLinePickClose<cr>",            desc = "Pick buffer to close" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",          desc = "Delete other buffers" },
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
      -- { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      -- { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      -- { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer right" },
      -- { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer left" },
    },
  },

  {
    "xvzc/chezmoi.nvim",
    keys = {
      {
        "<leader>fz",
        function()
          local czc = require('chezmoi.commands')
          require("fzf-lua").fzf_exec(
            czc.list({ args = { "--include=files" } }),
            {
              actions = {
                ["default"] = function(selected, _)
                  czc.edit({ targets = { "~/" .. selected[1] }, args = { "--watch" } })
                end
              }
            })
        end,
        desc = "Fzf Chezmoi File"
      },
    }
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "<c-/>", function() require("Comment.api").toggle.linewise.current() end, mode = { "i", "n", "x" }, desc = "Toggle line comment" },
      { "gc",    desc = "Line comment",                                           mode = { "n", "x" } },
      { "gb",    desc = "Block comment",                                          mode = { "n", "x" } },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      { "s",     function() require("flash").jump() end,              desc = "Flash",               mode = { "n", "x", "o" } },
      { "S",     function() require("flash").treesitter() end,        desc = "Flash Trweesitter",   mode = { "n", "o" } },
      { "r",     function() require("flash").remote() end,            desc = "Remote Flash",        mode = "o" },
      { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",   mode = { "o", "x" } },
      { "<c-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search", mode = { "c" } },
    },
  },

  -- TODO: fzf vim_options like telescope
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", "<cmd>FzfLua resume<cr>",                    desc = "Fzf Resume" },
      -- files
      { "<leader>,",       "<cmd>FzfLua buffers<cr>",                   desc = "Fzf Buffers" },
      { "<leader>ff",      "<cmd>FzfLua files<cr>",                     desc = "Fzf Files" },
      { "<leader>fr",      "<cmd>FzfLua oldfiles<cr>",                  desc = "Fzf Recent Files" },
      { "<leader>fg",      "<cmd>FzfLua git_files<cr>",                 desc = "Fzf Git Files" },
      { "<leader>ft",      "<cmd>FzfLua filetypes<cr>",                 desc = "Search Filetypes" },
      -- git
      { "<leader>gc",      "<cmd>FzfLua git_commits<cr>",               desc = "Search Git Commits" },
      { "<leader>gs",      "<cmd>FzfLua git_status<cr>",                desc = "Search Git Status" },
      -- search
      { "<leader>/",       "<cmd>FzfLua live_grep<cr>",                 desc = "Live Grep" },
      { "<leader>:",       "<cmd>FzfLua command_history<cr>",           desc = "Search Command History" },
      { '<leader>"',       "<cmd>FzfLua registers<cr>",                 desc = "Search Registers" },
      { "<leader>sc",      "<cmd>FzfLua commands<cr>",                  desc = "Search Neovim Commands" },
      { "<leader>sh",      "<cmd>FzfLua helptags<cr>",                  desc = "Search Help Pages" },
      { "<leader>sH",      "<cmd>FzfLua highlights<cr>",                desc = "Search Highlight Groups" },
      { "<leader>sa",      "<cmd>FzfLua autocmds<cr>",                  desc = "Search Auto Commands" },
      { "<leader>sm",      "<cmd>FzfLua marks<cr>",                     desc = "Search Marks" },
      { "<leader>sM",      "<cmd>FzfLua manpages<cr>",                  desc = "Search Man Pages" },
      { "<leader>sj",      "<cmd>FzfLua jumps<cr>",                     desc = "Search Jumps" },
      { "<leader>sk",      "<cmd>FzfLua keymaps<cr>",                   desc = "Search Keymaps" },
      { "<leader>sq",      "<cmd>FzfLua quickfix<cr>",                  desc = "Search Quickfix List" },
      { "<leader>sl",      "<cmd>FzfLua loclist<cr>",                   desc = "Search Location List" },
      { "<leader>sd",      "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Search Workspace Diagnostics" },
      { "<leader>sD",      "<cmd>FzfLua lsp_document_diagnostics<cr>",  desc = "Search Document Diagnostics" },
      { "<leader>uC",      "<cmd>FzfLua colorschemes<cr>",              desc = "Color Schemes" },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Search Options" },
    }
  },

  {
    "lewis6991/gitsigns.nvim",
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
      { "<leader>ghs", ":Gitsigns stage_hunk<cr>",                    desc = "Stage Hunk",           buffer = 0, mode = { 'n', 'v' } },
      { "<leader>ghu", ":Gitsigns undo_stage_hunk<cr>",               desc = "Undo Stage Hunk",      buffer = 0, mode = { 'n', 'v' } },
      { "<leader>ghr", ":Gitsigns reset_hunk<cr>",                    desc = "Reset Hunk",           buffer = 0, mode = { 'n', 'v' } },
      { "<leader>ghS", "<cmd>Gitsigns stage_buffer<cr>",              desc = "Stage Buffer",         buffer = 0 },
      { "<leader>ghR", "<cmd>Gitsigns reset_buffer<cr>",              desc = "Reset Buffer",         buffer = 0 },
      { "<leader>ghp", "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Hunk",         buffer = 0 },
      { "<leader>ghi", "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Preview Hunk Inline",  buffer = 0 },
      { "<leader>ghb", "<cmd>Gitsigns blame_line<cr>",                desc = "Blame Line",           buffer = 0 },
      { "<leader>ugB", "<cmd>Gitsigns blame<cr>",                     desc = "Blame Buffer",         buffer = 0 },
      { "<leader>ugb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",     buffer = 0 },
      { "<leader>ugw", "<cmd>Gitsigns toggle_word_diff<cr>",          desc = "Toggle Git Word Diff", buffer = 0 },
      -- { "<leader>ghd", "<cmd>Gitsigns diffthis<cr>",                  desc = "Diff This",            buffer = 0 },
      -- { "<leader>ghD", "<cmd>Gitsigns diffthis ~<cr>",                desc = "Diff This ~",          buffer = 0 },
      { 'ih',          ":<c-u>Gitsigns select_hunk<cr>",              desc = "Select Hunk",          buffer = 0, mode = { "o", "x" } },
    },
  },

  {
    "echasnovski/mini.files",
    keys = {
      { "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "mini.files browser (current file)" },
      { "<leader>fM", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "mini.files (cwd)" },
    },
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "ms", desc = "Add surrounding",                     mode = { "n", "v" } },
      { "md", desc = "Delete surrounding" },
      { "mf", desc = "Find right surrounding" },
      { "mF", desc = "Find left surrounding" },
      { "mh", desc = "Highlight surrounding" },
      { "mr", desc = "Replace surrounding" },
      { "mn", desc = "Update `MiniSurround.config.n_lines`" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    keys = {
      { '<leader>k',  vim.lsp.buf.hover,                                                                         desc = "LSP Hover",             buffer = 0 },
      -- { '<c-k>',      vim.lsp.buf.signature_help,                                                                desc = "LSP Signature Documentation", buffer = 0, mode = "i" },
      -- { ']d',         vim.diagnostic.goto_next,                                                                  desc = "Next Diagnostic",             buffer = 0 },
      -- { '[d',         vim.diagnostic.goto_prev,                                                                  desc = "Previous Diagnostic",         buffer = 0 },
      -- { 'gd',         vim.lsp.buf.definition,                                                                desc = "LSP Definition",              buffer = 0 },
      -- { 'gD',         vim.lsp.buf.declaration,                                                               desc = "LSP Declaration",             buffer = 0 },
      { 'gd',         "<cmd>FzfLua lsp_definitions jump_to_single_result=true ignore_current_line=true<cr>",     desc = "LSP Definition",        buffer = 0 },
      { 'gD',         "<cmd>FzfLua lsp_declarations jump_to_single_result=true ignore_current_line=true<cr>",    desc = "LSP Declaration",       buffer = 0 },
      { 'gr',         "<cmd>FzfLua lsp_references ignore_current_line=true<cr>",                                 desc = "LSP References",        buffer = 0 },
      { 'gI',         "<cmd>FzfLua lsp_implementations jump_to_single_result=true ignore_current_line=true<cr>", desc = "LSP Implementation",    buffer = 0 },
      { 'gy',         "<cmd>FzfLua lsp_typedefs jump_to_single_result=true ignore_current_line=true<cr>",        desc = "LSP Type Definition",   buffer = 0 },
      -- { 'g.',         vim.lsp.buf.code_action,                                                                   desc = "LSP Code Action",             buffer = 0, mode = { "n", "v" } },
      { 'g.',         "<cmd>FzfLua lsp_code_actions<cr>",                                                        desc = "LSP Code Action",       buffer = 0, mode = { "n", "v" } },
      { '<leader>ca', "<cmd>FzfLua lsp_code_actions<cr>",                                                        desc = "LSP Code Action",       buffer = 0, mode = { "n", "v" } },
      { '=',          vim.lsp.buf.format,                                                                        desc = "LSP Format",            buffer = 0, mode = { "n", "v" } },
      { '<leader>ci', "<cmd>LspInfo<cr>",                                                                        desc = "LSP Info",              buffer = 0 },
      -- { '<leader>cr', vim.lsp.buf.rename,         desc = "LSP Rename",                  buffer = 0 },
      { '<leader>o',  "<cmd>FzfLua lsp_document_symbols<cr>",                                                    desc = "LSP Document Symbols",  buffer = 0 },
      { '<leader>O',  "<cmd>FzfLua lsp_workspace_symbols<cr>",                                                   desc = "LSP Workspace Symbols", buffer = 0 },
    },
  },

  {
    "smjonas/inc-rename.nvim",
    keys = {
      { '<leader>cr', ":IncRename ", desc = "LSP Rename", buffer = 0 },
    },
  },

  {
    "jake-stewart/multicursor.nvim",
    keys = function()
      local mc = require("multicursor-nvim")
      return {
        { "J",             function() mc.lineAddCursor(1) end,     desc = 'Add cursor below',                       mode = { "n", "v" } },
        { "K",             function() mc.lineAddCursor(-1) end,    desc = 'Add cursor above',                       mode = { "n", "v" } },
        { "<a-s-j>",       function() mc.lineSkipCursor(1) end,    desc = 'Move main cursor below',                 mode = { "n", "v" } },
        { "<a-s-k>",       function() mc.lineSkipCursor(-1) end,   desc = 'Move main cursor above',                 mode = { "n", "v" } },
        { "<c-n>",         function() mc.matchAddCursor(1) end,    desc = 'Add cursor next cword/sel',              mode = { "n", "v" } },
        { "<c-p>",         function() mc.matchAddCursor(-1) end,   desc = 'Add cursor previous cword/sel',          mode = { "n", "v" } },
        { "<a-c-n>",       function() mc.matchSkipCursor(1) end,   desc = 'Move main cursor next cword/sel',        mode = { "n", "v" } },
        { "<a-c-p>",       function() mc.matchSkipCursor(-1) end,  desc = 'Move main cursor previous cword/sel',    mode = { "n", "v" } },
        { "mcA",           mc.matchAllAddCursors,                  desc = 'Add cursor to all cword/sel',            mode = { "n", "v" } },
        -- BUG: next/prevCursor removes cursors when looping around (fixed by disabling wrap)
        { "L",             function() mc.nextCursor(false) end,    desc = 'Move main cursor to next selection',     mode = { "n", "v" } },
        { "H",             function() mc.prevCursor(false) end,    desc = 'Move main cursor to previous selection', mode = { "n", "v" } },
        -- BUG: first/lastCursor removes cursors
        { "<a-s-l>",       mc.lastCursor,                          desc = 'Move main cursor to last selection',     mode = { "n", "v" } },
        { "<a-s-h>",       mc.firstCursor,                         desc = 'Move main cursor to first selection',    mode = { "n", "v" } },
        { "<c-i>",         mc.jumpForward,                         desc = 'Jump forwards',                          mode = { "n", "v" } },
        { "<c-o>",         mc.jumpBackward,                        desc = 'Jump backwards',                         mode = { "n", "v" } },
        { "<c-c>",         mc.deleteCursor,                        desc = 'Delete main cursor' },
        { "mcx",           mc.deleteCursor,                        desc = 'Delete main cursor',                     mode = { "n", "v" } },
        { "mcc",           mc.toggleCursor,                        desc = 'Add/remove main cursor',                 mode = { "n", "v" } },
        { "mcd",           mc.duplicateCursors,                    desc = 'Duplicate cursors',                      mode = { "n", "v" } },
        { "mcq",           mc.clearCursors,                        desc = 'Clear cursors' },
        { "<c-leftmouse>", mc.handleMouse,                         desc = 'Add/remove cursor' },
        { "<leader>gv",    mc.restoreCursors,                      desc = 'Restore cursors' },
        { "&",             mc.alignCursors,                        desc = 'Align cursors' },
        { "mca",           mc.alignCursors,                        desc = 'Align cursors' },
        { "I",             mc.insertVisual,                        desc = 'Insert before cursors',                  mode = "v" },
        { "A",             mc.appendVisual,                        desc = 'Append after cursors',                   mode = "v" },
        { "S",             mc.splitCursors,                        desc = 'Split cursors',                          mode = "v" },
        { "M",             mc.matchCursors,                        desc = 'Match cursors',                          mode = "v" },
        { "mct",           function() mc.transposeCursors(1) end,  desc = 'Transpose selections forwards',          mode = "v" },
        { "mcT",           function() mc.transposeCursors(-1) end, desc = 'Transpose selections backwards',         mode = "v" },
        { "mcl",           function() mc.swapCursors(1) end,       desc = 'Swap selection forwards',                mode = "v" },
        { "mch",           function() mc.swapCursors(-1) end,      desc = 'Swap selection backwards',               mode = "v" },
        {
          "<esc>",
          function()
            if not mc.cursorsEnabled() then
              mc.enableCursors()
            elseif mc.hasCursors() then
              mc.clearCursors()
            else
              vim.cmd.noh()
            end
          end,
          desc = "Escape and clear hlsearch",
        },
      }
    end
  },

  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  },

  {
    "nvimtools/none-ls.nvim",
    keys = {
      { "<leader>cI", "<cmd>NullLsInfo<cr>", desc = "Null Ls Info", buffer = 0 },
    },
  },

  {
    "danymat/neogen",
    keys = {
      { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" },
    },
  },

  {
    "folke/noice.nvim",
    keys = {
      { "<leader>sn", function() require("noice").cmd("pick") end, desc = "Search Notifications" },
    }
  },

  -- -- TODO: helix keybinds for navigating treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   keys = {
  --     {
  --       '<a-o>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():parent())
  --       end,
  --       desc = 'Parent Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<a-n>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():next_sibling())
  --       end,
  --       desc = 'Next Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --     {
  --       '<a-p>',
  --       function()
  --         require('nvim-treesitter.ts_utils').goto_node(vim.treesitter.get_node():prev_sibling())
  --       end,
  --       desc = 'Previous Treesitter Node',
  --       mode = { 'n', 'v' },
  --     },
  --   },
  -- },

  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<a-c>",      function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
      { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
      { "<c-'>",      function() Snacks.terminal() end,                desc = "Toggle Terminal",             mode = { "n", "i", "t" } },
      -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
      -- { "<leader>dps", function() Snacks.profiler.scratch() end,        desc = "Profiler Scratch Bufer" },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "]t",         function() require("todo-comments").jump_next() end,                                         desc = "Next todo comment" },
      { "[t",         function() require("todo-comments").jump_prev() end,                                         desc = "Previous Todo Comment" },
      { "<leader>st", function() require('todo-comments.fzf').todo() end,                                          desc = "Search Todo" },
      { "<leader>sT", function() require('todo-comments.fzf').todo({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end, desc = "Search Todo/Fix/Fixme" },
    }
  },

  {
    "lambdalisue/vim-suda",
    keys = {
      {
        "<c-s>",
        function()
          local buf = vim.api.nvim_win_get_buf(0)
          if vim.bo[buf].readonly then
            vim.cmd.SudaWrite()
          else
            vim.cmd.write()
          end
        end,
        desc = "Save file",
        mode = { "i", "x", "n", "s" },
      },
      { "<c-s-s>", "<cmd>wa<cr>", desc = "Save all files" },
    },
  },

  {
    "folke/persistence.nvim",
    keys = {
      { "<leader>ss", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>sl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      {
        "<c-s-q>",
        function()
          require("persistence").stop(); vim.cmd([[:qa]])
        end,
        desc = "Quit Neovim without saving session"
      },
    },
  },

  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      { "<c-h>",   function() require("smart-splits").move_cursor_left() end },
      { "<c-j>",   function() require("smart-splits").move_cursor_down() end },
      { "<c-k>",   function() require("smart-splits").move_cursor_up() end },
      { "<c-l>",   function() require("smart-splits").move_cursor_right() end },
      { "<c-\\>",  function() require("smart-splits").move_cursor_previous() end },
      { "<c-a-h>", function() require("smart-splits").resize_left() end },
      { "<c-a-j>", function() require("smart-splits").resize_down() end },
      { "<c-a-k>", function() require("smart-splits").resize_up() end },
      { "<c-a-l>", function() require("smart-splits").resize_right() end },
      { "<c-w>R",  function() require("smart-splits").start_resize_mode() end },
      { "<c-s-h>", function() require("smart-splits").swap_buf_left() end },
      { "<c-s-j>", function() require("smart-splits").swap_buf_down() end },
      { "<c-s-k>", function() require("smart-splits").swap_buf_up() end },
      { "<c-s-l>", function() require("smart-splits").swap_buf_right() end },
    },
  },

  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                                  desc = "Diagnostics (Trouble)", },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",                     desc = "Buffer Diagnostics (Trouble)", },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                          desc = "Symbols (Trouble)", },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false<cr>",                              desc = "LSP Definitions / references / ... (Trouble)", },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                                      desc = "Location List (Trouble)", },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                                       desc = "Quickfix List (Trouble)", },
      { "<leader>xt", "<cmd>Trouble todo toggle focus filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle<cr>",                                         desc = "Todo (Trouble)" },
    }
  },

  {
    "linux-cultist/venv-selector.nvim",
    keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
  },

  {
    "mikavilpas/yazi.nvim",
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>",        desc = "Open yazi at the current file", },
      { "<leader>fY", "<cmd>Yazi cwd<cr>",    desc = "Open yazi in nvim's working directory", },
      { "<leader>y",  "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session", },
    },
  },

  {
    "folke/which-key.nvim",
    keys = {
      { "<s-f1>", function() require("which-key").show() end,                   desc = "Keymaps (which-key)",        mode = { "n", "i", "x" } },
      { "<f1>",   function() require("which-key").show({ global = false }) end, desc = "Buffer keymaps (which-key)", mode = { "n", "i", "x" } },
    },
  },

}
