-- ======================== SESSION ========================

vim.opt.clipboard      = "unnamedplus" -- Sync with system clipboard

vim.opt.undofile       = true          -- Enable persistent undo (see also `:h undodir`)
vim.opt.undolevels     = 10000         -- Set undo history size

-- ======================== WINDOW ========================

-- Always keep n lines above/below cursor unless at start/end of file
vim.opt.scrolloff      = 10 -- keep cursor in center of screen == 999
vim.opt.sidescrolloff  = 5

-- ======================== EDITOR ========================

-- Enable relative line numbers with current line as absolute number
vim.opt.number         = true
vim.opt.relativenumber = true

-- Appearance
vim.opt.breakindent    = true  -- Indent wrapped lines to match line start
vim.opt.cursorline     = true  -- Highlight current line
vim.opt.linebreak      = true  -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.opt.splitbelow     = true  -- Horizontal splits will be below
vim.opt.splitright     = true  -- Vertical splits will be to the right

vim.opt.wrap           = false -- Display long lines as just one line

-- Editing
vim.opt.ignorecase     = true    -- Ignore case when searching (use `\C` to force not doing that)
vim.opt.incsearch      = true    -- Show search results while typing
vim.opt.infercase      = true    -- Infer letter cases for a richer built-in keyword completion
vim.opt.smartcase      = true    -- Don't ignore case when searching if pattern has upper case
vim.opt.smartindent    = true    -- Make indenting smart

vim.opt.textwidth      = 80      -- Set wrap text width
vim.opt.formatoptions  = "qcrj1" -- Don't autoformat comments when useing 'o' or 'O'
