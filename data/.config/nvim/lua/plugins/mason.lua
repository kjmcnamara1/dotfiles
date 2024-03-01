return {
  -- ui to install LSPs, DAPs, linters, and formatters
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonUpdate", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
  keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
  build = ":MasonUpdate",
  opts = {
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✔️",
        package_pending = "",
        package_uninstalled = "✗",
      },
    },
  },
}
