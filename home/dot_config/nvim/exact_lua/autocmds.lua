local CustomGroup = vim.api.nvim_create_augroup("Custom", { clear = true })

-- vim.api.nvim_create_autocmd("BufModifiedset", {
--   desc = "Close non-modifiable buffers with <esc>",
--   group = CustomGroup,
--   callback = function()
--     if vim.o.modifiable ~= true and vim.o.filetype ~= "trouble" then
--       vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = true, silent = true })
--     end
--   end
-- })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  group = CustomGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format file on save",
  group = CustomGroup,
  callback = function()
    vim.lsp.buf.format()
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  desc = "Show cursor line when entering window",
  group = CustomGroup,
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  desc = "Hide cursor line when leaving window",
  group = CustomGroup,
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

return {}
