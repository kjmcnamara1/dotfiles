return {
  "folke/trouble.nvim",
  cond = not vim.g.vscode,
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
  keys = {
    { "<leader>dd", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
    { "<leader>dw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>dD", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
    { "<leader>dq", "<cmd>TroubleToggle quickfix<cr>",              desc = "QuickFix List" },
    { "<leader>dl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },
    { "gd",         "<cmd>TroubleToggle lsp_definitions<cr>",       desc = "LSP Definitions" },
    { "gr",         "<cmd>TroubleToggle lsp_references<cr>",        desc = "LSP References" },
    { "gt",         "<cmd>TroubleToggle lsp_type_definitions<cr>",  desc = "LSP Type Definitions" },
  },
  opts = {
    padding = false,
    multiline = false,
    win_config = { border = "rounded" },
    signs = { error = " ", warning = " ", information = " ", hint = "󰠠 ", other = " " }
  },
}
