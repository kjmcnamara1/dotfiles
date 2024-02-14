-- ======================== KEYS ========================

-- Map leader key to <space> and localleader to '\'
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Keymap timeout length in ms
-- opt.timeoutlen = 300

-- ======================== EDITOR ========================

-- Enable relative line numbers with current line as absolute number
vim.opt.relativenumber = true

-- Set tab to 2 spaces and round indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true

-- Enable auto indenting and set to spaces
vim.opt.shiftwidth = 2

-- Turn off text wrap by default
vim.opt.wrap = false

-- Preview incremental substitute
-- vim.opt.inccommand = "split"

-- Show invisible characters
vim.opt.listchars = "trail:∙,extends:󰇘,precedes:󰇘,conceal:,nbsp:␣"

-- Place a column line
-- vim.opt.colorcolumn = '80'

-- Vim Autoformatting Options
-- vim.g.autoformat = true
-- vim.opt.formatoptions = "jcroqlnt" -- tcqj
-- vim.opt.grepformat = "%f:%l:%c:%m"
-- vim.opt.grepprg = "rg --vimgrep"
-- vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Jump to matching bracket when inserting
-- vim.opt.showmatch = true

-- Conceal text options
-- vim.opt.conceallevel = 3 -- Hide * markup for bold and italic
-- vim.opt.concealcursor = 'nc'

-- ======================== WINDOW ========================

-- Always keep n lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Minimum window width
-- vim.opt.winminwidth = 5

-- Global statusline for all windows -- Handled by lualine opt
-- vim.opt.laststatus = 3

-- vim.opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Folding options for ufo plugin
vim.opt.foldcolumn = "auto:9"
-- vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  -- foldsep = " ",
  eob = " ",
}

-- ======================== SESSION ========================

-- Confirm to save changes before exiting modified buffer
-- vim.opt.confirm = true

-- Sync with system clipboard
vim.opt.clipboard = "unnamedplus"

-- Auto write file when leaving ubffer
vim.opt.autowrite = true

-- Save swap file and trigger CursorHold
vim.opt.updatetime = 200

-- Enable persistent undo history
vim.opt.undolevels = 10000

-- Items to remember for saving/loading sessions
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- ===================== set by MINI.BASICS =============================
-- --------------------- options.basic ---------------------------
-- vim.g.mapleader = ' ' -- Use space as the one and only true Leader key
-- General
-- vim.o.undofile    = true  -- Enable persistent undo (see also `:h undodir`)

-- vim.o.backup      = false -- Don't store backup while overwriting the file
-- vim.o.writebackup = false -- Don't store backup while overwriting the file

-- vim.o.mouse       = 'a'   -- Enable mouse for all available modes

-- vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- Appearance
-- vim.o.breakindent   = true    -- Indent wrapped lines to match line start
-- vim.o.cursorline    = true    -- Highlight current line
-- vim.o.linebreak     = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
-- vim.o.number        = true    -- Show line numbers
-- vim.o.splitbelow    = true    -- Horizontal splits will be below
-- vim.o.splitright    = true    -- Vertical splits will be to the right

-- vim.o.ruler         = false   -- Don't show cursor position in command line
-- vim.o.showmode      = false   -- Don't show mode in command line
-- vim.o.wrap          = false   -- Display long lines as just one line

-- vim.o.signcolumn    = 'yes'   -- Always show sign column (otherwise it will shift text)
-- vim.o.fillchars     = 'eob: ' -- Don't show `~` outside of buffer

-- Editing
-- vim.o.ignorecase  = true -- Ignore case when searching (use `\C` to force not doing that)
-- vim.o.incsearch   = true -- Show search results while typing
-- vim.o.infercase   = true -- Infer letter cases for a richer built-in keyword completion
-- vim.o.smartcase   = true -- Don't ignore case when searching if pattern has upper case
-- vim.o.smartindent = true -- Make indenting smart

-- vim.o.completeopt   = 'menuone,noinsert,noselect' -- Customize completions
-- vim.o.virtualedit   = 'block'                     -- Allow going past the end of line in visual block mode
-- vim.o.formatoptions = 'qjl1'                      -- Don't autoformat comments

-- Neovim version dependent
-- if vim.fn.has('nvim-0.9') == 1 then
-- 	vim.opt.shortmess:append('WcC') -- Reduce command line messages
-- 	vim.o.splitkeep = 'screen'      -- Reduce scroll during window split
-- else
-- 	vim.opt.shortmess:append('Wc')  -- Reduce command line messages
-- end

-- if vim.fn.has('nvim-0.10') == 0 then
-- 	vim.o.termguicolors = true -- Enable gui colors
-- end

-- --------------------- options.extra_ui ---------------------------
-- vim.o.pumblend  = 10 -- Make builtin completion menus slightly transparent
-- vim.o.pumheight = 10 -- Make popup menu smaller
-- vim.o.winblend  = 10 -- Make floating windows slightly transparent

-- vim.o.listchars = 'tab:> ,extends:…,precedes:…,nbsp:␣' -- Define which helper symbols to show
-- vim.o.list      = true                                 -- Show some helper symbols

-- if vim.fn.exists("syntax_on") ~= 1 then vim.cmd([[syntax enable]]) end
