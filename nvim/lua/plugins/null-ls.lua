return {
  -- -- automatically install debuggers, linters, and formatters
  -- NOTE: NONE-LS is loaded by 'BufReadPost'
  --    which requires MASON-NULL-LS
  --      which requires MASON
  -- so order = BufReadPost -> MASON -> MASON-NULL-LS -> NONE-LS
  {
    "nvimtools/none-ls.nvim",
    cond = not vim.g.vscode,
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
      { "LhKipp/nvim-nu", build = ":TSInstall nu", config = true, },
    },
    event = { "BufReadPost", "BufNewFile" }, --Loads and attaches after other LSPs
    cmd = { "NullLsInfo", "NullLsLog" },
    keys = {
      { "<leader>cI", "<cmd>NullLsInfo<cr>", desc = "Null Ls Info", buffer = 0 },
    },
    config = function()
      local null_ls = require("null-ls")
      local diag = null_ls.builtins.diagnostics
      local fmt = null_ls.builtins.formatting
      local hover = null_ls.builtins.hover

      -- TODO: need to add nvim-nu
      null_ls.setup({
        sources = {
          -- fmt.prettierd.with({
          --   extra_filetypes = { "toml" },
          -- }),
          -- diag.shellcheck,
          -- ca.shellcheck,
          -- fmt.beautysh,
          diag.fish,
          fmt.fish_indent,
          fmt.shfmt.with({
            extra_filetypes = { "zsh" },
            extra_args = { "-i", "2", "-bn", "-ci", "-sr", "-kp" },
          }),
          hover.printenv,
        }
      })
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    cond = not vim.g.vscode,
    dependencies = {
      "williamboman/mason.nvim",
    },
    cmd = { "NullLsInstall", "NullLsUninstall" },
    opts = {
      ensure_installed = {
        "prettierd",
        -- 'shellcheck', -- use bashls
        "shfmt", -- instead of beautysh
        "debugpy",
      },
      handlers = {},
      -- Installs any tools listed in null-ls sources
      -- Only works if mason-null-ls is required after null-ls
      -- automatic_installation = true,
    },
  },
}
