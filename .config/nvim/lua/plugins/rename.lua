return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>cr",
      ":IncRename ",
      -- function()
      --   return ":IncRename " .. vim.fn.expand("<cword>")
      -- end,
      -- expr = true,
      desc = "LSP Rename",
      buffer = 0,
    },
  },
  config = true,
}
