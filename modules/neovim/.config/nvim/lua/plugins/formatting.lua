return {
  "stevearc/conform.nvim",
  enabled = false,
  cond = not vim.g.vscode,
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          lsp_fallback = true,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Conform Format",
    },
  },
  opts = {
    formatters_by_ft = {
      -- lua = { "stylua" },
      sh = { "beautysh" },
      python = { "blue" },
      javascript = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      yaml = { "prettier" },
      json = { "prettier" },
      markdown = { "prettier" },
    },
    -- format_on_save = {
    --   lsp_fallback = true,
    --   timeout_ms = 1000,
    -- },
  },
}
