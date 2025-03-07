vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  pattern = {
    ['.*/wallust/templates/.*'] = function(path)
      local parent = vim.fs.basename(vim.fs.dirname(path))
      if parent == 'templates' then
        return 'jinja'
      end
    end,
  },
})

return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jinja_lsp = {},
      },
    },
  },

}
