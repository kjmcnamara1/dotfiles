local function map(mode, lhs, rhs, opts)
  local default_opts = { noremap = true, silent = true }
  local new_opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  return vim.keymap.set(mode, lhs, rhs, new_opts)
end

-- Quick exit from Insert mode
map("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- Save file
map({ "i", "x", "n", "s" }, "<c-s>", "<cmd>w!<cr>", { desc = "Save file" })

-- Quit NeoVim
map("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit NeoVim" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Capital U for Redo
map("n", "U", "<c-r>", { desc = "Redo" })

-- Paste in insert mode
map("i", "<c-v>", "<c-r>+", { desc = "Paste from system clipboard" })

-- Delete right in insert mode
map("i", "<c-l>", "<del>", { desc = "Delete right" })

-- Copy/paste -- solved with clipboard=unnamedplus
-- use 'p' in visual mode to replace register with selected text
-- use 'P' in visual mode to keep register the same (reuse yanked text)
-- map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
-- map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
-- map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- Reselect latest changed, put, or yanked text
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" })

-- Search inside visually highlighted text. Use `silent = false` for it to take effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- Search visually selected text
if vim.fn.has("nvim-0.10") == 0 then
  map("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search forward" })
  map("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search backward" })
end

-- Quck find/replace for the word under the cursor
map("n", "S", function()
  local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Find/Replace word under cursor" })

-- Move by visible lines.
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })

-- Add empty lines before and after cursor line supporting dot-repeat
map("n", "<a-O>", "O<esc>", { desc = "Put empty line above" })
map("n", "<a-o>", "o<esc>", { desc = "Put empty line below" })

-- Buffers & Tabs
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

map("n", "<c-c>", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<a-s-h>", "<cmd>tabp<cr>", { desc = "Switch to previous tab" })
map("n", "<a-s-l>", "<cmd>tabn<cr>", { desc = "Switch to next tab" })
-- map("n", "<leader>`", "<cmd>exe 'tabn '.g:lasttab<cr>", { desc = "Switch to other tab" }) -- need to create an autocmd to record last tab number

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "=", "=gv")

-- Better beginning / end of lines ( modes Norm, Vis, Sel, Opr)
map("", "H", "^", { desc = "Beginning of Line" })
map("", "L", "$", { desc = "End of Line" })

-- Window navigation
map({ "n", "t" }, "<c-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map({ "n", "t" }, "<c-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map({ "n", "t" }, "<c-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map({ "n", "t" }, "<c-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })

-- Window resize (respecting `v:count`)
map("n", "<c-Left>", '"<Cmd>vertical resize -" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window width" })
map("n", "<c-Down>", '"<Cmd>resize -"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Decrease window height" })
map("n", "<c-Up>", '"<Cmd>resize +"          . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window height" })
map("n", "<c-Right>", '"<Cmd>vertical resize +" . v:count1 . "<CR>"',
  { expr = true, replace_keycodes = false, desc = "Increase window width" })

-- Window split
map("n", "<c-w>\\", "<cmd>wincmd v<cr>", { desc = "Split window right" })
-- map("n", "<c-bslash>", "<cmd>wincmd v<cr>", { desc = "Split window right" })
map("n", "<c-w>-", "<cmd>wincmd s<cr>", { desc = "Split window below" })
-- map("n", "<c-m>", "<cmd>wincmd s<cr>", { desc = "Split window below" }) -- same as <c-minus>

-- Move cursor
map({ "i", "t", "c" }, "<a-h>", "<left>", { desc = "Cursor left", remap = true })
map({ "i", "t", "c" }, "<a-l>", "<right>", { desc = "Cursor right", remap = true })
map({ "i", "t", "c" }, "<a-j>", "<down>", { desc = "Cursor down", remap = true })
map({ "i", "t", "c" }, "<a-k>", "<up>", { desc = "Cursor up", remap = true })

-- Move Lines
map("n", "<a-s-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<a-s-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<a-s-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<a-s-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<a-s-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<a-s-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Keep buffer centered during vertical movements (unnecessary with `scrolloff=999`)
-- map("n", "<c-d>", "<c-d>zz", { remap = true, desc = "Scroll half page down" })
-- map("n", "<c-u>", "<c-u>zz", { remap = true, desc = "Scroll half page up" })
-- map("n", "{", "{zz", { remap = true, desc = "Scroll paragraph down" })
-- map("n", "}", "}zz", { remap = true, desc = "Scroll paragraph up" })
-- map("n", "n", "nzz", { remap = true, desc = "Next search result" })
-- map("n", "N", "Nzz", { remap = true, desc = "Previous search result" })
-- map("n", "<c-o>", "<c-o>zz", { remap = true, desc = "Previous jump" })
-- map("n", "<c-i>", "<c-i>zz", { remap = true, desc = "Next jump" })
-- map("n", "*", "*zz", { remap = true, desc = "Next word under cursor" })
-- map("n", "#", "#zz", { remap = true, desc = "Previous word under cursor" })

-- Lazy Plugin Manager
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Press gx to open the link under the cursor
map("n", "gx", ":sil !open <cWORD><cr>")

-- Resize split windows to be equal size
-- map("n", "<leader>=", "<cmd>wincmd =<cr>", { desc = "Equal window size" })

-- Highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- Unmap 's' for mini.surround
-- map("n", "s", "<nop>")

-- Toggle Options
map("n", "<localleader>b", '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  { desc = "Toggle 'background'" })
map("n", "<localleader>c", "<Cmd>setlocal cursorline! cursorline?<CR>", { desc = "Toggle 'cursorline'" })
map("n", "<localleader>C", "<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>", { desc = "Toggle 'cursorcolumn'" })
map("n", "<localleader>d", "<Cmd>lua print(MiniBasics.toggle_diagnostic())<CR>", { desc = "Toggle diagnostic" })
map("n", "<localleader>h", '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = "Toggle search highlight" })
map("n", "<localleader>i", "<Cmd>setlocal ignorecase! ignorecase?<CR>", { desc = "Toggle 'ignorecase'" })
map("n", "<localleader>l", "<Cmd>setlocal list! list?<CR>", { desc = "Toggle 'list'" })
map("n", "<localleader>n", "<Cmd>setlocal number! number?<CR>", { desc = "Toggle 'number'" })
map("n", "<localleader>r", "<Cmd>setlocal relativenumber! relativenumber?<CR>", { desc = "Toggle 'relativenumber'" })
map("n", "<localleader>s", "<Cmd>setlocal spell! spell?<CR>", { desc = "Toggle 'spell'" })
map("n", "<localleader>w", "<Cmd>setlocal wrap! wrap?<CR>", { desc = "Toggle 'wrap'" })

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

-- Search inside visually highlighted text. Use `silent = false` for it to take effect immediately.
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
