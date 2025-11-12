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

      { "<leader>j", "J",                 desc = "Join Lines",                  mode = { 'n', 'v' } },
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
      { "<a-j>",              ":m '>+1<cr>gv=gv",            desc = "Move down",             mode = { "v" } },
      { "<a-k>",              ":m '<-2<cr>gv=gv",            desc = "Move up",               mode = { "v" } },
      -- { "<a-j>",              "<esc><cmd>m .+1<cr>==gi",     desc = "Move down",             mode = { "i" } }, -- Clashes with move cursor
      -- { "<a-k>",              "<esc><cmd>m .-2<cr>==gi",     desc = "Move up",               mode = { "i" } }, -- Clashes with move cursor

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
      { "<a-s-l>",    "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
      { "<a-s-h>",    "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      -- { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      -- { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      -- { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer right" },
      -- { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer left" },
    },
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

  -- TODO: write custom Snacks.pickers
  {
    "ibhagwan/fzf-lua",
    keys = {
      -- { "<leader>ft", "<cmd>FzfLua filetypes<cr>",                desc = "Fzf Filetypes" },
      { "<leader>so", "<cmd>FzfLua nvim_options<cr>",             desc = "Search Neovim Options" },
      -- { "<leader>sd", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", desc = "Search Workspace Diagnostics" },
      { "<leader>sD", "<cmd>FzfLua lsp_document_diagnostics<cr>", desc = "Search Document Diagnostics" },
    },
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
      { "<leader>hs",  ":Gitsigns stage_hunk<cr>",                    desc = "Stage Hunk",           buffer = 0, mode = { 'n', 'v' } },
      { "<leader>hu",  ":Gitsigns undo_stage_hunk<cr>",               desc = "Undo Stage Hunk",      buffer = 0, mode = { 'n', 'v' } },
      { "<leader>hr",  ":Gitsigns reset_hunk<cr>",                    desc = "Reset Hunk",           buffer = 0, mode = { 'n', 'v' } },
      { "<leader>hS",  "<cmd>Gitsigns stage_buffer<cr>",              desc = "Stage Buffer",         buffer = 0 },
      { "<leader>hR",  "<cmd>Gitsigns reset_buffer<cr>",              desc = "Reset Buffer",         buffer = 0 },
      { "<leader>hp",  "<cmd>Gitsigns preview_hunk<cr>",              desc = "Preview Hunk",         buffer = 0 },
      { "<leader>hi",  "<cmd>Gitsigns preview_hunk_inline<cr>",       desc = "Preview Hunk Inline",  buffer = 0 },
      { "<leader>hb",  "<cmd>Gitsigns blame_line<cr>",                desc = "Blame Line",           buffer = 0 },
      { "<leader>ugB", "<cmd>Gitsigns blame<cr>",                     desc = "Blame Buffer",         buffer = 0 },
      { "<leader>ugb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Git Blame",     buffer = 0 },
      { "<leader>ugw", "<cmd>Gitsigns toggle_word_diff<cr>",          desc = "Toggle Git Word Diff", buffer = 0 },
      -- { "<leader>ghd", "<cmd>Gitsigns diffthis<cr>",                  desc = "Diff This",            buffer = 0 },
      -- { "<leader>ghD", "<cmd>Gitsigns diffthis ~<cr>",                desc = "Diff This ~",          buffer = 0 },
      { 'ih',          ":<c-u>Gitsigns select_hunk<cr>",              desc = "Select Hunk",          buffer = 0, mode = { "o", "x" } },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    keys = {
      { "<leader>um", "<cmd>Markview toggle<cr>",       desc = "Toggle Render Markdown",      ft = "markdown" },
      { "<leader>uM", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Markview Hybrid Mode", ft = "markdown" },
      { "<c-t>",      "<cmd>Checkbox toggle<cr>",       desc = "Toggle Checkbox",             ft = "markdown" },
      { "<leader>cb", "<cmd>Checkbox interactive<cr>",  desc = "Interactive Checkbox",        ft = "markdown" },
      { "<c-right>",  "<cmd>Heading increase<cr>",      desc = "Increase Heading",            ft = "markdown" },
      { "<c-left>",   "<cmd>Heading decrease<cr>",      desc = "Decrease Heading",            ft = "markdown" },
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
      { '<leader>cC', "<cmd>lua =vim.lsp.get_clients()[1].server_capabilities<cr>", desc = "LSP Capabilities", buffer = 0 },
      { '<leader>k',  vim.lsp.buf.hover,                                            desc = "LSP Hover",        buffer = 0 },
      -- { '<c-k>',      vim.lsp.buf.signature_help,                                                desc = "LSP Signature Documentation", buffer = 0, mode = "i" },
      { '<leader>ci', "<cmd>LspInfo<cr>",                                           desc = "LSP Info",         buffer = 0 },
      { '<leader>cr', vim.lsp.buf.rename,                                           desc = "LSP Rename",       buffer = 0 },
    },
  },

  {
    "smjonas/inc-rename.nvim",
    keys = {
      { 'grn', ":IncRename ",                                                   desc = "LSP IncRename", buffer = 0 },
      { 'grN', function() return ":IncRename " .. vim.fn.expand("<cword>") end, desc = "LSP IncRename", buffer = 0, expr = true },
    },
  },

  {
    "jake-stewart/multicursor.nvim",
    keys = function()
      local mc = require("multicursor-nvim")
      return {
        { "J",             function() mc.lineAddCursor(1) end,     desc = 'MultiCursor: Add cursor below',                       mode = { "n", "v" } },
        { "K",             function() mc.lineAddCursor(-1) end,    desc = 'MultiCursor: Add cursor above',                       mode = { "n", "v" } },
        { "<c-s-j>",       function() mc.lineSkipCursor(1) end,    desc = 'MultiCursor: Move main cursor below',                 mode = { "n", "v" } },
        { "<c-s-k>",       function() mc.lineSkipCursor(-1) end,   desc = 'MultiCursor: Move main cursor above',                 mode = { "n", "v" } },
        { "<c-n>",         function() mc.matchAddCursor(1) end,    desc = 'MultiCursor: Add cursor next cword/sel',              mode = { "n", "v" } },
        { "<c-p>",         function() mc.matchAddCursor(-1) end,   desc = 'MultiCursor: Add cursor previous cword/sel',          mode = { "n", "v" } },
        { "<a-c-n>",       function() mc.matchSkipCursor(1) end,   desc = 'MultiCursor: Move main cursor next cword/sel',        mode = { "n", "v" } },
        { "<a-c-p>",       function() mc.matchSkipCursor(-1) end,  desc = 'MultiCursor: Move main cursor previous cword/sel',    mode = { "n", "v" } },
        { "mcA",           mc.matchAllAddCursors,                  desc = 'MultiCursor: Add cursor to all cword/sel',            mode = { "n", "v" } },
        { "L",             function() mc.nextCursor(false) end,    desc = 'MultiCursor: Move main cursor to next selection',     mode = { "n", "v" } },
        { "H",             function() mc.prevCursor(false) end,    desc = 'MultiCursor: Move main cursor to previous selection', mode = { "n", "v" } },
        { "<c-s-l>",       mc.lastCursor,                          desc = 'MultiCursor: Move main cursor to last selection',     mode = { "n", "v" } },
        { "<c-s-h>",       mc.firstCursor,                         desc = 'MultiCursor: Move main cursor to first selection',    mode = { "n", "v" } },
        { "<c-i>",         mc.jumpForward,                         desc = 'MultiCursor: Jump forwards',                          mode = { "n", "v" } },
        { "<c-o>",         mc.jumpBackward,                        desc = 'MultiCursor: Jump backwards',                         mode = { "n", "v" } },
        { "<c-c>",         mc.deleteCursor,                        desc = 'MultiCursor: Delete main cursor' },
        { "mcx",           mc.deleteCursor,                        desc = 'MultiCursor: Delete main cursor',                     mode = { "n", "v" } },
        { "mcc",           mc.toggleCursor,                        desc = 'MultiCursor: Add/remove main cursor',                 mode = { "n", "v" } },
        { "mcd",           mc.duplicateCursors,                    desc = 'MultiCursor: Duplicate cursors',                      mode = { "n", "v" } },
        { "mcq",           mc.clearCursors,                        desc = 'MultiCursor: Clear cursors' },
        { "<c-leftmouse>", mc.handleMouse,                         desc = 'MultiCursor: Add/remove cursor' },
        { "<leader>gv",    mc.restoreCursors,                      desc = 'MultiCursor: Restore cursors' },
        { "&",             mc.alignCursors,                        desc = 'MultiCursor: Align cursors' },
        { "mca",           mc.alignCursors,                        desc = 'MultiCursor: Align cursors' },
        { "I",             mc.insertVisual,                        desc = 'MultiCursor: Insert before cursors',                  mode = "v" },
        { "A",             mc.appendVisual,                        desc = 'MultiCursor: Append after cursors',                   mode = "v" },
        { "S",             mc.splitCursors,                        desc = 'MultiCursor: Split cursors',                          mode = "v" },
        { "M",             mc.matchCursors,                        desc = 'MultiCursor: Match cursors',                          mode = "v" },
        { "mct",           function() mc.transposeCursors(1) end,  desc = 'MultiCursor: Transpose selections forwards',          mode = "v" },
        { "mcT",           function() mc.transposeCursors(-1) end, desc = 'MultiCursor: Transpose selections backwards',         mode = "v" },
        { "mcl",           function() mc.swapCursors(1) end,       desc = 'MultiCursor: Swap selection forwards',                mode = "v" },
        { "mch",           function() mc.swapCursors(-1) end,      desc = 'MultiCursor: Swap selection backwards',               mode = "v" },
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
          desc = "MultiCursor:Escape and clear hlsearch",
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
      -- Top Pickers & Explorer
      { "<leader>pp",      function() Snacks.picker.pickers() end,                                                desc = "Pick: Pickers" },
      { "<leader><space>", function() Snacks.picker.smart() end,                                                  desc = "Pick: Smart Files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                                desc = "Pick: Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                                   desc = "Pick: Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                                        desc = "Pick: Command History" },
      { "<leader>e",       function() Snacks.explorer() end,                                                      desc = "Pick: File Explorer" },
      -- find
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                desc = "Pick: Config Files" },
      { "<leader>fz",      function() Snacks.picker.chezmoi_files() end,                                          desc = "Pick: Chezmoi File" },
      { "<leader>ff",      function() Snacks.picker.files() end,                                                  desc = "Pick: Files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                                              desc = "Pick: Git Files" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                               desc = "Pick: Projects" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                                 desc = "Pick: Recent" },
      { "<leader>ft",      function() Snacks.picker.filetypes() end,                                              desc = "Pick: Filetypes", },
      -- git
      { "<leader>gb",      function() Snacks.picker.git_branches() end,                                           desc = "Pick: Git Branches" },
      { "<leader>gc",      function() Snacks.picker.git_log() end,                                                desc = "Pick: Git Log (Commits)" },
      { "<leader>gL",      function() Snacks.picker.git_log_line() end,                                           desc = "Pick: Git Log Line" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                                             desc = "Pick: Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                                              desc = "Pick: Git Stash" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                               desc = "Pick: Git Diff (Hunks)" },
      { "<leader>gf",      function() Snacks.picker.git_log_file() end,                                           desc = "Pick: Git Log File" },
      -- GitHub
      { "<leader>ghi",     function() Snacks.picker.gh_issue() end,                                               desc = "Pick: GitHub Issues (open)" },
      { "<leader>ghI",     function() Snacks.picker.gh_issue({ state = "all" }) end,                              desc = "Pick: GitHub Issues (all)" },
      { "<leader>ghp",     function() Snacks.picker.gh_pr() end,                                                  desc = "Pick: GitHub Pull Requests (open)" },
      { "<leader>ghP",     function() Snacks.picker.gh_pr({ state = "all" }) end,                                 desc = "Pick: GitHub Pull Requests (all)" },
      -- grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                                  desc = "Pick: Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                           desc = "Pick: Grep Open Buffers" },
      { "<leader>sw",      function() Snacks.picker.grep_word() end,                                              desc = "Pick: Visual selection or word",   mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() Snacks.picker.registers() end,                                              desc = "Pick: Registers" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                                         desc = "Pick: Search History" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                               desc = "Pick: Autocmds" },
      { "<leader>sc",      function() Snacks.picker.commands() end,                                               desc = "Pick: Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                            desc = "Pick: Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                                     desc = "Pick: Buffer Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                                   desc = "Pick: Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                                             desc = "Pick: Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                                  desc = "Pick: Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                                  desc = "Pick: Jumps" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                desc = "Pick: Keymaps" },
      { "<leader>sm",      function() Snacks.picker.marks() end,                                                  desc = "Pick: Marks" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                                    desc = "Pick: Man Pages" },
      { "<leader>sO",      function() Snacks.picker.nvim_options() end,                                           desc = "Pick: Neovim Options" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                                   desc = "Pick: Search for Plugin Spec" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                                 desc = "Pick: Quickfix List" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                                desc = "Pick: Location List" },
      { "<leader>st",      function() Snacks.picker.todo_comments() end,                                          desc = "Pick: Todo" },
      { "<leader>sT",      function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end, desc = "Pick: Todo/Fix/Fixme" },
      { "<leader>sR",      function() Snacks.picker.resume() end,                                                 desc = "Pick: Resume" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                                   desc = "Pick: Undo History" },
      { "<leader>sy",      function() Snacks.picker.cliphist() end,                                               desc = "Pick: Clipboard" },
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                                           desc = "Pick: Colorschemes" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,                                        desc = "LSP: Goto Definition" },
      { "grd",             function() Snacks.picker.lsp_declarations() end,                                       desc = "LSP: Goto Declaration" },
      { "grr",             function() Snacks.picker.lsp_references() end,                                         desc = "LSP: References",                  nowait = true },
      { "gri",             function() Snacks.picker.lsp_implementations() end,                                    desc = "LSP: Goto Implementation" },
      { "grt",             function() Snacks.picker.lsp_type_definitions() end,                                   desc = "LSP: Goto Type Definition" },
      { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                                     desc = "LSP: C[a]lls Incoming" },
      { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                                     desc = "LSP: C[a]lls Outgoing" },
      { "go",              function() Snacks.picker.lsp_symbols() end,                                            desc = "LSP: Symbols" },
      { "gO",              function() Snacks.picker.lsp_workspace_symbols() end,                                  desc = "LSP: Workspace Symbols" },
      { "grf",             function() Snacks.rename.rename_file() end,                                            desc = "LSP: Rename File" },


      { "<leader>.",       function() Snacks.scratch() end,                                                       desc = "Toggle Scratch Buffer" },
      { "<leader>S",       function() Snacks.scratch.select() end,                                                desc = "Select Scratch Buffer" },

      { "<leader>n",       function() Snacks.notifier.hide() end,                                                 desc = "Notifications: Dismiss All" },
      { "<leader>N",       function() Snacks.notifier.show_history() end,                                         desc = "Notifications: History" },
      { "<leader>sn",      function() Snacks.picker.notifications() end,                                          desc = "Pick: Search Notifications" },

      { "<leader>bd",      function() Snacks.bufdelete() end,                                                     desc = "Delete Buffer" },
      { "<a-c>",           function() Snacks.bufdelete() end,                                                     desc = "Delete Buffer" },
      { "<leader>gB",      function() Snacks.gitbrowse() end,                                                     desc = "Git Browse" },
      { "<leader>gb",      function() Snacks.git.blame_line() end,                                                desc = "Git Blame Line" },
      { "<leader>gF",      function() Snacks.lazygit.log_file() end,                                              desc = "Lazygit Current File History" },
      { "<leader>gg",      function() Snacks.lazygit() end,                                                       desc = "Lazygit" },
      { "<leader>gl",      function() Snacks.lazygit.log() end,                                                   desc = "Lazygit Log (cwd)" },
      { "<c-'>",           function() Snacks.terminal() end,                                                      desc = "Toggle Terminal",                  mode = { "n", "i", "t" } },
      { "<a-t>",           function() Snacks.terminal() end,                                                      desc = "Toggle Terminal",                  mode = { "n", "i", "t" } },
      -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",              function() Snacks.words.jump(vim.v.count1) end,                                        desc = "Next Reference",                   mode = { "n", "t" } },
      { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                                       desc = "Prev Reference",                   mode = { "n", "t" } },
      -- { "<leader>dps", function() Snacks.profiler.scratch() end,        desc = "Profiler Scratch Bufer" },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
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
      -- { "<c-s-s>", "<cmd>wa<cr>", desc = "Save all files" },
      { "<c-s-s>", "<cmd>noautocmd w<cr>", desc = "Save without autoformatting" },
    },
  },

  {
    "folke/persistence.nvim",
    keys = {
      { "<leader>ss", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>sS", function() require("persistence").select() end,              desc = "Select Session" },
      { "<leader>sL", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      {
        "<c-s-q>",
        function()
          require("persistence").stop(); vim.cmd([[:qa!]])
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
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                          desc = "Symbols (Trouble)", },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>",                              desc = "LSP Definitions / references / ... (Trouble)", },
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
      { "<leader>fy", "<cmd>Yazi<cr>",        desc = "Open yazi at the current file",         mode = { 'n', 'v' }, },
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
