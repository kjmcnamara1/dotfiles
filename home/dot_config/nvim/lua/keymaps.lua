return {

  {
    "echasnovski/mini.files",
    keys = {
      { "<leader>fm", function() require("mini.files").open(vim.api.nvim_buf_get_name(0), true) end, desc = "mini.files browser (current file)" },
      { "<leader>fM", function() require("mini.files").open(vim.uv.cwd(), true) end,                 desc = "mini.files (cwd)" },
    },
  },

  {
    "rmehri01/onenord.nvim",
    keys = {
      { "<c-q>",      "<cmd>qa<cr>",       desc = "Quit NeoVim" },
      { "U",          "<c-r>",             desc = "Redo" },
      -- { "<del>",      "<c-o>x",            desc = "Delete",                    mode = "i" },
      -- { ",",          ";",           desc = "Repeat Character Movement Forward" },
      -- { ";",          ",",           desc = "Repeat Character Movement Backward" },
      { "<leader>j",  "J",                 desc = "Join Lines" },
      { "<a-O>",      "O<esc>",            desc = "Put empty line above" },
      { "<a-o>",      "o<esc>",            desc = "Put empty line below" },
      { "<a-i>",      "^",                 desc = "Start of Line" },
      { "<a-a>",      "$",                 desc = "End of Line" },
      { "<leader>ui", vim.show_pos,        desc = "Inspect Pos" },
      { "<esc>",      "<cmd>noh<cr><esc>", desc = "Escape and clear hlsearch", mode = { "i", "n" } },
      { "<leader>L",  "<cmd>Lazy<cr>",     desc = "Lazy Plugin Manager" },
      { "<esc>",      "<cmd>close<cr>",    desc = "Close Lazy",                ft = "lazy" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>'",  "<cmd>e #<cr>",                            desc = "Alternate Buffer" },
      { "<leader>bb", "<cmd>BufferLinePick<cr>",                 desc = "Pick buffer" },
      { "<leader>bx", "<cmd>BufferLinePickClose<cr>",            desc = "Pick buffer to close" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",            desc = "Toggle pin" },
      { "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<cr>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>",          desc = "Delete other buffers" },
      { "<leader>bl", "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer right" },
      { "<leader>bh", "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer left" },
      { "<a-h>",      "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev buffer" },
      { "<a-l>",      "<cmd>BufferLineCycleNext<cr>",            desc = "Next buffer" },
      { "[b",         "<cmd>BufferLineCyclePrev<cr>",            desc = "Prev Buffer" },
      { "]b",         "<cmd>BufferLineCycleNext<cr>",            desc = "Next Buffer" },
      { "[B",         "<cmd>BufferLineMovePrev<cr>",             desc = "Move buffer right" },
      { "]B",         "<cmd>BufferLineMoveNext<cr>",             desc = "Move buffer left" },
    },
  },

  {
    "folke/flash.nvim",
    keys = {
      { "s",     function() require("flash").jump() end,              desc = "Flash",               mode = { "n", "x", "o" } },
      { "S",     function() require("flash").treesitter() end,        desc = "Flash Trweesitter",   mode = { "n", "x", "o" } },
      { "r",     function() require("flash").remote() end,            desc = "Remote Flash",        mode = "o" },
      { "R",     function() require("flash").treesitter_search() end, desc = "Treesitter Search",   mode = { "o", "x" } },
      { "<c-s>", function() require("flash").toggle() end,            desc = "Toggle Flash Search", mode = { "c" } },
    },
  },

  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader><space>", "<cmd>FzfLua resume<cr>",          desc = "Fzf Resume" },
      -- files
      { "<leader>,",       "<cmd>FzfLua buffers<cr>",         desc = "Fzf Buffers" },
      { "<leader>ff",      "<cmd>FzfLua files<cr>",           desc = "Fzf Files" },
      { "<leader>fr",      "<cmd>FzfLua oldfiles<cr>",        desc = "Fzf Recent Files" },
      { "<leader>fg",      "<cmd>FzfLua git_files<cr>",       desc = "Fzf Git Files" },
      { "<leader>ft",      "<cmd>FzfLua filetypes<cr>",       desc = "Search Filetypes" },
      -- git
      { "<leader>gc",      "<cmd>FzfLua git_commits<cr>",     desc = "Search Git Commits" },
      { "<leader>gs",      "<cmd>FzfLua git_status<cr>",      desc = "Search Git Status" },
      -- search
      { "<leader>/",       "<cmd>FzfLua live_grep<cr>",       desc = "Live Grep" },
      { "<leader>:",       "<cmd>FzfLua command_history<cr>", desc = "Search Command History" },
      { '<leader>"',       "<cmd>FzfLua registers<cr>",       desc = "Search Registers" },
      { "<leader>sc",      "<cmd>FzfLua commands<cr>",        desc = "Search Neovim Commands" },
      { "<leader>sh",      "<cmd>FzfLua helptags<cr>",        desc = "Search Help Pages" },
      { "<leader>sH",      "<cmd>FzfLua highlights<cr>",      desc = "Search Highlight Groups" },
      { "<leader>sa",      "<cmd>FzfLua autocmds<cr>",        desc = "Search Auto Commands" },
      { "<leader>sm",      "<cmd>FzfLua marks<cr>",           desc = "Search Marks" },
      { "<leader>sM",      "<cmd>FzfLua manpages<cr>",        desc = "Search Man Pages" },
      { "<leader>sj",      "<cmd>FzfLua jumps<cr>",           desc = "Search Jumps" },
      { "<leader>sk",      "<cmd>FzfLua keymaps<cr>",         desc = "Search Keymaps" },
      { "<leader>sq",      "<cmd>FzfLua quickfix<cr>",        desc = "Search Quickfix List" },
      { "<leader>sl",      "<cmd>FzfLua loclist<cr>",         desc = "Search Location List" },
      { "<leader>uC",      "<cmd>FzfLua colorschemes<cr>",    desc = "Color Schemes" },
    },
  },


  {
    "neovim/nvim-lspconfig",
    opts = {
      on_attach = function(_, bufnr)
        local map = function(lhs, rhs, desc, opts)
          opts = vim.deepcopy(opts or {})
          local mode = opts.mode or "n"
          opts.mode = nil
          desc = desc and "LSP: " .. desc
          opts = vim.tbl_deep_extend("keep", { buffer = bufnr, desc = desc }, opts)
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- TODO: Finish LSP Keymaps
        map("gh", vim.lsp.buf.hover, "Hover")
        map("<c-h>", vim.lsp.buf.signature_help, "Signature Documentation", { mode = "i" })
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
        -- nmap('<leader>cr', ':IncRename ', 'IncRename')
        map("gd", vim.lsp.buf.definition, "Go to Definition")
        map("gD", vim.lsp.buf.declaration, "Declaration")
        map("g.", vim.lsp.buf.code_action, "Code Action", { mode = { "n", "v" } })
        map("<leader>cf", vim.lsp.buf.format, "Format", { mode = { "n", "v" } })
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { mode = { "n", "v" } })
        map("<leader>ci", "<cmd>LspInfo<cr>", "Info")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      end
    },
  },

  {
    "williamboman/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  },

  {
    "danymat/neogen",
    keys = {
      { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" },
    },
  },

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
    },
  },

  {
    "saifulapm/commasemi.nvim",
    keys = {
      { "<localleader>,", desc = "Toggle , at End of Line" },
      { "<localleader>;", desc = "Toggle ; at End of Line" },
    }
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
