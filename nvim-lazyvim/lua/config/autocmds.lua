-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

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

vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  desc = "Show cursor line when entering window",
  group = augroup("auto_cursorline"),
  callback = function()
    if vim.w.auto_cursorline then
      vim.wo.cursorline = true
      vim.w.auto_cursorline = nil
    end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  desc = "Hide cursor line when leaving window",
  group = augroup("auto_cursorline"),
  callback = function()
    if vim.wo.cursorline then
      vim.w.auto_cursorline = true
      vim.wo.cursorline = false
    end
  end,
})

-- Set filetypes
vim.filetype.add({
  -- extension = {
  --   rasi = "rasi"
  -- },
  pattern = {
    [".*%.conf.*"] = "conf",
    -- [".*/hypr/.*%.conf"] = "hyprlang",
    -- [".*%.rasi"] = "rasi",
  }
})
