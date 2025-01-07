-- ================================================================================
-- * Mason (ui to install LSPs, DAPs, linters, and formatters)
-- ================================================================================

return {

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
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

}
