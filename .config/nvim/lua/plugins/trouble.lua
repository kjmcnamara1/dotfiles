return {
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = { "Trouble", "TroubleClose", "TroubleToggle", "TroubleRefresh" },
  keys = {
    { "<leader>xx", "<cmd>TroubleToggle<cr>",                       desc = "Toggle Trouble" },
    { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Document Diagnostics" },
    { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",              desc = "QuickFix List" },
    { "<leader>xl", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List" },
    { "gd",         "<cmd>TroubleToggle lsp_definitions<cr>",       desc = "LSP Definitions" },
    { "gr",         "<cmd>TroubleToggle lsp_references<cr>",        desc = "LSP References" },
    { "gt",         "<cmd>TroubleToggle lsp_type_definitions<cr>",  desc = "LSP Type Definitions" },
  },
  opts = {
    multiline = false,
    win_config = { border = "rounded" },
    use_diagnostic_signs = true,
  },
}
