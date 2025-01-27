return {

  {
    "nvimtools/none-ls.nvim",
    cond = not vim.g.vscode,
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPost", "BufNewFile" }, --Loads and attaches after other LSPs
    cmd = { "NullLsInfo", "NullLsLog" },
    opts = function(_, opts)
      -- local nls = require("null-ls")
      opts.root_dir = opts.root_dir
          or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      -- opts.sources = vim.list_extend(opts.sources or {}, {
      --   nls.builtins.formatting.fish_indent,
      --   nls.builtins.diagnostics.fish,
      --   nls.builtins.formatting.stylua,
      --   nls.builtins.formatting.shfmt,
      -- })
    end,
  },

}
