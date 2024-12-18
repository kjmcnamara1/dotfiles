-- Map leader key to <space> and localleader to '\'
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- ===================== Lazy.nvim Plugin Manager =============================
-- Set lazy data folder location where plugins will download
local lazypath       = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Add plugin data path to beginning of vim runtime path
vim.opt.rtp:prepend(lazypath)

-- Lazy options
local opts = not vim.g.vscode and {
  defaults = { lazy = true },
  install = { colorscheme = { "onenord" } },
  ui = {
    border = "rounded",
    title = "Lazy Plugin Manager",
  },
  checker = { enabled = true, frequency = 86400 },
  change_detection = { notify = false },
} or {}

-- Load Lazy.nvim
require("lazy").setup("plugins", opts)

-- Load vscode settings
if vim.g.vscode then
  require("core.vscode")
end

-- Vim options
require("core.options")

-- Custom keymaps
require("core.keymaps")

-- Custom autocmds
require("core.autocmds")

-- Set filetypes
vim.filetype.add({
  extension = {
    rasi = "rasi"
  },
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    -- [".*%.rasi"] = "rasi",
  }
})
