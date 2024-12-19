-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Quit NeoVim
map("n", "<c-q>", "<cmd>qa<cr>", { desc = "Quit NeoVim" })

-- Capital U for Redo
map("n", "U", "<c-r>", { desc = "Redo" })

-- Paste in insert mode
map("i", "<c-v>", "<c-r>+", { desc = "Paste from system clipboard" })

-- Reselect latest changed, put, or yanked text
map("n", "gV", '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" })

-- Quck find/replace for the word under the cursor -- overrides Flash treesitter
-- map("n", "S", function()
--   local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
--   local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
--   vim.api.nvim_feedkeys(keys, "n", false)
-- end, { desc = "Find/Replace word under cursor" })

-- Add empty lines before and after cursor line supporting dot-repeat
map("n", "<a-O>", "O<esc>", { desc = "Put empty line above" })
map("n", "<a-o>", "o<esc>", { desc = "Put empty line below" })

-- Buffers & Tabs
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New file" })
map("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to other buffer" })
-- map("n", "<a-c>", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })

-- Better indenting
map("v", "=", "=gv")
