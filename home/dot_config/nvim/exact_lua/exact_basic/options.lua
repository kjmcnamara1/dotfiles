vim.opt.laststatus     = 0 -- Turn off statusline
vim.opt.scrolloff      = 0
vim.opt.sidescrolloff  = 0
vim.opt.number         = false
vim.opt.relativenumber = false

vim.opt.showmode       = false
vim.opt.showcmd        = false
vim.opt.shortmess:append("F")

return {
  "rmehri01/onenord.nvim",
  keys = {
    { "<c-q>", "<cmd>qa!<cr>", desc = "Quit" },
  },
}
