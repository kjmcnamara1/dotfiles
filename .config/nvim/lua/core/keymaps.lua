local function map(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }
  local new_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  return vim.keymap.set(mode, lhs, rhs, new_opts)
end

-- Quick exit from Insert mode
map("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- Quit NeoVim
map("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit NeoVim" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Paste in insert mode
map("i", "<c-v>", "<c-r>+", { desc = "Paste from system clipboard" })

-- Paste without losing the contents of the register
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })

-- Capital U for Redo
map("n", "U", "<c-r>", { desc = "Redo" })

-- Buffers
map("n", "<leader>n", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
-- map("n", "<leader>`", "<cmd>exe 'tabn '.g:lasttab<cr>", { desc = "Switch to other tab" }) -- need to create an autocmd to record last tab number

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "=", "=gv")

-- Better beginning / end of lines ( modes Norm, Vis, Sel, Opr)
map("", "H", "^", { desc = "Beginning of Line" })
map("", "L", "$", { desc = "End of Line" })

-- Move cursor
map({"i",'t','c'}, "<c-h>", "<left>", { desc = "Cursor left" ,noremap=false})
map({"i",'t','c'}, "<c-l>", "<right>", { desc = "Cursor right" ,noremap=false})
map({"i",'t'}, "<c-j>", "<down>", { desc = "Cursor down" ,noremap=false})
map({"i",'t'}, "<c-k>", "<up>", { desc = "Cursor up" ,noremap=false})

-- Move to window using the <ctrl> hjkl keys
map({ "n", "t" }, "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map({ "n", "t" }, "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map({ "n", "t" }, "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map({ "n", "t" }, "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Move Lines
map("n", "<a-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<a-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<a-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<a-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<a-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<a-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Keep buffer centered during vertical movements
map("n", "<c-d>", "<c-d>zz", { remap = true, desc = "Scroll half page down" })
map("n", "<c-u>", "<c-u>zz", { remap = true, desc = "Scroll half page up" })
map("n", "{", "{zz", { remap = true, desc = "Scroll paragraph down" })
map("n", "}", "}zz", { remap = true, desc = "Scroll paragraph up" })
map("n", "n", "nzz", { remap = true, desc = "Next search result" })
map("n", "N", "Nzz", { remap = true, desc = "Previous search result" })
map("n", "<c-o>", "<c-o>zz", { remap = true, desc = "Previous jump" })
map("n", "<c-i>", "<c-i>zz", { remap = true, desc = "Next jump" })
map("n", "*", "*zz", { remap = true, desc = "Next word under cursor" })
map("n", "#", "#zz", { remap = true, desc = "Previous word under cursor" })

-- Lazy Plugin Manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Press gx to open the link under the cursor
-- map("n", "gx", ":sil !open <cWORD><cr>")

-- Resize split windows to be equal size
-- map("n", "<leader>=", "<cmd>wincmd =<cr>", { desc = "Equal window size" })

-- Save file - included with mini.basics
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Unmap 's' for mini.surround
-- map("n", "s", "<nop>")

-- ===================== set by MINI.BASICS =============================
-- --------------------- mappings.basic ---------------------------
-- Move by visible lines.
-- map({ 'n', 'x' }, 'j', [[v:count == 0 ? 'gj' : 'j']], { expr = true })
-- map({ 'n', 'x' }, 'k', [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Add empty lines before and after cursor line supporting dot-repeat
-- map('n', 'gO', 'v:lua.MiniBasics.put_empty_line(v:true)',  { expr = true, desc = 'Put empty line above' })
-- map('n', 'go', 'v:lua.MiniBasics.put_empty_line(v:false)', { expr = true, desc = 'Put empty line below' })

-- Copy/paste with system clipboard
-- map({ 'n', 'x' }, 'gy', '"+y', { desc = 'Copy to system clipboard' })
-- map(  'n',        'gp', '"+p', { desc = 'Paste from system clipboard' })

-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
-- map(  'x',        'gp', '"+P', { desc = 'Paste from system clipboard' })

-- Reselect latest changed, put, or yanked text
-- map('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, replace_keycodes = false, desc = 'Visually select changed text' })

-- Search inside visually highlighted text. Use `silent = false` for it to make effect immediately.
-- map('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- Search visually selected text 
-- if vim.fn.has('nvim-0.10') == 0 then
-- 	map('x', '*', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = 'Search forward' })
-- 	map('x', '#', [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = 'Search backward' })
-- end

-- Alternative way to save and exit in Normal mode.
-- map(  'n',        '<C-S>', '<Cmd>silent! update | redraw<CR>',      { desc = 'Save' })
-- map({ 'i', 'x' }, '<C-S>', '<Esc><Cmd>silent! update | redraw<CR>', { desc = 'Save and go to Normal mode' })

-- --------------------- mappings.option_toggle_prefix ---------------------------
-- map_toggle('b', '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"<CR>', "Toggle 'background'")
-- map_toggle('c', '<Cmd>setlocal cursorline!<CR>',                                    "Toggle 'cursorline'")
-- map_toggle('C', '<Cmd>setlocal cursorcolumn!<CR>',                                  "Toggle 'cursorcolumn'")
-- map_toggle('d', '<Cmd>lua MiniBasics.toggle_diagnostic()<CR>',                      'Toggle diagnostic')
-- map_toggle('h', '<Cmd>let v:hlsearch = 1 - v:hlsearch<CR>',                         'Toggle search highlight')
-- map_toggle('i', '<Cmd>setlocal ignorecase!<CR>',                                    "Toggle 'ignorecase'")
-- map_toggle('l', '<Cmd>setlocal list!<CR>',                                          "Toggle 'list'")
-- map_toggle('n', '<Cmd>setlocal number!<CR>',                                        "Toggle 'number'")
-- map_toggle('r', '<Cmd>setlocal relativenumber!<CR>',                                "Toggle 'relativenumber'")
-- map_toggle('s', '<Cmd>setlocal spell!<CR>',                                         "Toggle 'spell'")
-- map_toggle('w', '<Cmd>setlocal wrap!<CR>',                                          "Toggle 'wrap'")

-- --------------------- mappings.windows ---------------------------
-- Window navigation
-- map('n', '<C-H>', '<C-w>h', { desc = 'Focus on left window' })
-- map('n', '<C-J>', '<C-w>j', { desc = 'Focus on below window' })
-- map('n', '<C-K>', '<C-w>k', { desc = 'Focus on above window' })
-- map('n', '<C-L>', '<C-w>l', { desc = 'Focus on right window' })

-- Window resize (respecting `v:count`)
-- map('n', '<C-Left>',  '"<Cmd>vertical resize -" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window width' })
-- map('n', '<C-Down>',  '"<Cmd>resize -"          . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Decrease window height' })
-- map('n', '<C-Up>',    '"<Cmd>resize +"          . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window height' })
-- map('n', '<C-Right>', '"<Cmd>vertical resize +" . v:count1 . "<CR>"', { expr = true, replace_keycodes = false, desc = 'Increase window width' })

-- --------------------- mappings.move_with_alt ---------------------------
-- Move only sideways in command mode. 
-- map('c', '<M-h>', '<Left>',  { silent = false, desc = 'Left' })
-- map('c', '<M-l>', '<Right>', { silent = false, desc = 'Right' })

-- Don't `noremap` in insert mode to have these keybindings behave exactly
-- like arrows (crucial inside TelescopePrompt)
-- map('i', '<M-h>', '<Left>',  { noremap = false, desc = 'Left' })
-- map('i', '<M-j>', '<Down>',  { noremap = false, desc = 'Down' })
-- map('i', '<M-k>', '<Up>',    { noremap = false, desc = 'Up' })
-- map('i', '<M-l>', '<Right>', { noremap = false, desc = 'Right' })

-- map('t', '<M-h>', '<Left>',  { desc = 'Left' })
-- map('t', '<M-j>', '<Down>',  { desc = 'Down' })
-- map('t', '<M-k>', '<Up>',    { desc = 'Up' })
-- map('t', '<M-l>', '<Right>', { desc = 'Right' })

