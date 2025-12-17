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

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  group = CustomGroup,
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Resize splits if window got resized",
  group = CustomGroup,
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- NOTE: Replaced with conform.nvim
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   desc = "Format file on save",
--   group = CustomGroup,
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

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

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  desc = "Auto create dir when saving a file, in case some intermediate directory does not exist",
  group = CustomGroup,
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help in vertical split",
  group = CustomGroup,
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.bo.buflisted = false
    vim.cmd.wincmd("L")
    vim.api.nvim_win_set_width(0, 80)
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Health windows settings",
  group = CustomGroup,
  pattern = "checkhealth",
  callback = function()
    vim.bo.bufhidden = "wipe"
    vim.bo.buflisted = false
    vim.keymap.set("n", "<esc>", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})

return {}
