local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight selection on yank",
  group = augroup("highlight_yank"),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, visual = true })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Go to last location when opening a buffer",
  group = augroup("last_loc"),
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

vim.api.nvim_create_autocmd({ "VimResized" }, {
  desc = "Resize splits if window got resized",
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Close some filetypes with `q`",
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Enable spell checking and text wrapping for text filetypes",
--   group = augroup("wrap_spell"),
--   pattern = { "gitcommit", "markdown", "txt" },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--   end,
-- })
--
-- Auto create dir when saving a file, in case some intermediate directory does not exist
-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = augroup("auto_create_dir"),
--   callback = function(event)
--     if event.match:match("^%w%w+://") then
--       return
--     end
--     local file = vim.uv.fs_realpath(event.match) or event.match
--     vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open help in vertical split",
  group = augroup("vertical_help"),
  pattern = "help",
  callback = function()
    vim.bo.bufhidden = "unload"
    vim.cmd.wincmd("L")
    -- vim.cmd.wincmd("=")
    vim.api.nvim_win_set_width(0, 80)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format file on save",
  group = augroup("lsp_format"),
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Set position, size, and mode of git commit window",
--   group = augroup("gitcommit"),
--   pattern = "gitcommit,NeogitCommitMessage",
--   callback = function()
--     -- if vim.g.in_diffview then
--     --   vim.cmd.wincmd("J")
--     --   vim.api.nvim_win_set_height(0, math.min(20, math.floor(.5 * vim.o.lines)))
--     -- else
--     vim.cmd.wincmd("L")
--     vim.api.nvim_win_set_width(0, math.min(66, math.floor(.5 * vim.o.columns)))
--     -- end
--     vim.cmd.startinsert()
--   end
-- })
--
-- vim.api.nvim_create_autocmd("TermOpen", {
--   desc = "Set Terminal Options",
--   group = augroup("terminal"),
--   callback = function()
--     vim.wo.relativenumber = false
--     vim.wo.number = false
--     vim.cmd.startinsert()
--   end
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   desc = "Set commentstring for hyprlang",
--   group = augroup("hyprlang"),
--   pattern = "hyprlang",
--   callback = function()
--     vim.bo.commentstring = "# %s"
--   end,
-- })
---

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  desc = "Show cursor line when entering window",
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  desc = "Hide cursor line when leaving window",
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})
