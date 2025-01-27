return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- used for rename, references, outline, and linting, etc.
        bashls = {},
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- shfmt is needed for formatting
        nls.builtins.formatting.shfmt.with({
          extra_filetypes = { "zsh" },
          extra_args = { "-i", "2", "-bn", "-ci", "-sr", "-kp" },
        }),
        -- reveals value of environment variable on hover
        nls.builtins.hover.printenv,
      })
    end,
  },

}
