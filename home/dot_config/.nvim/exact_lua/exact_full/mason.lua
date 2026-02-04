-- ================================================================================
-- * Mason (ui to install LSPs, DAPs, linters, and formatters)
-- ================================================================================

return {

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      ui = {
        -- border = "rounded",
        height = .8,
        icons = {
          package_installed = "✔️",
          package_pending = "",
          package_uninstalled = "✗",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "williamboman/mason.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    opts = {},
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = "williamboman/mason.nvim",
    -- lazy = false,
    -- cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync", "MasonToolsClean" },
    opts_extend = { "ensure_installed" },
    opts = {
      auto_update = true,
      run_on_start = true,
    },
  }

}
