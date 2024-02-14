-- Vim options
require("core.options")

-- Custom keymaps
require("core.keymaps")

-- Custom autocmds
require("core.autocmds")

-- ===================== Lazy.nvim Plugin Manager =============================
-- Set lazy data folder location where plugins will download
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
local opts = {
  --defaults = { lazy = true },
  install = { colorscheme = { "onenord" } },
  ui = {
    border='rounded',
    title='Lazy Plugin Manager',
  },
  checker = {enabled = true},
  change_detection = { notify = false },
}

-- Load Lazy.nvim
require("lazy").setup("plugins", opts)
