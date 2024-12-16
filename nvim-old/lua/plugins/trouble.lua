-- FIXME: Need to update for new version
return {
  "folke/trouble.nvim",
  cond = not vim.g.vscode,
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = "Trouble",
  keys = {
    { "<leader>dd", "<cmd>Trouble diagnostics toggle<cr>",          desc = "Toggle Trouble" },
    -- { "<leader>dw", "<cmd>Trouble workspace_diagnostics<cr>",         desc = "Workspace Diagnostics" },
    -- { "<leader>dD", "<cmd>Trouble document_diagnostics<cr>",          desc = "Document Diagnostics" },
    { "<leader>dq", "<cmd>Trouble quickfix toggle<cr>",             desc = "QuickFix List" },
    { "<leader>dl", "<cmd>Trouble loclist toggle<cr>",              desc = "Location List" },
    { "gd",         "<cmd>Trouble lsp_definitions toggle <cr>",     desc = "LSP Definitions" },
    { "gr",         "<cmd>Trouble float_references toggle<cr>",     desc = "LSP References" },
    { "gt",         "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "LSP Type Definitions" },
  },
  opts = {
    auto_preview = false,
    auto_jump = true,
    focus = true,
    -- padding = false,
    -- multiline = false,
    -- win_config = { border = "rounded" },
    -- signs = { error = " ", warning = " ", information = " ", hint = "󰠠 ", other = " " }
    modes = {
      float_references = {
        mode = "lsp_references",
        auto_preview = true,
        indent_guides = false,
        pinned = true,
        keys = { ["<esc>"] = "close", ["<cr>"] = "jump_close" },
        win = {
          type = "float",
          relative = "cursor",
          position = { 2, 10 },
          size = { height = 10, width = 50 },
          border = { "╭", "─", "╮", "│", "│", "┄", "│", "│" }, -- ╭╮╰╯─│
          title = "References",
          title_pos = "center",
        },
        preview = {
          type = "float",
          relative = "win",
          anchor = "NE",
          position = { 10, 51 },
          size = { height = 10, width = 50 },
          border = "rounded",
          focusable = false,
          fixed = true,
        }
      },
    },
  },
}
