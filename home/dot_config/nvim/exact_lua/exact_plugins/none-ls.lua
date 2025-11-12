return {

  {
    "jay-babu/mason-null-ls.nvim",
    cond = not vim.g.vscode,
    dependencies = { "nvimtools/none-ls.nvim" },
    event = { "BufReadPost", "BufNewFile" }, --Loads and attaches after other LSPs
    cmd = { "NullLsInstall", "NullLsUninstall" },
    opts = {
      automatic_installation = true,
    },
  },

  {
    "nvimtools/none-ls.nvim",
    cond = not vim.g.vscode,
    dependencies = { "williamboman/mason.nvim" },
    cmd = { "NullLsInfo", "NullLsLog" },
    opts = function(_, opts)
      -- local nls = require("null-ls")
      -- opts.sources = vim.list_extend(opts.sources or {}, {
      --   nls.builtins.formatting.prettierd.with({
      --     -- disabled_filetypes = { 'markdown' },
      --   }),
      -- })
      opts.root_dir = opts.root_dir
          or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
    end,
  }

}
