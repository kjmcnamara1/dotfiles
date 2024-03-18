return {
  {
    -- Adds labels for marks to sign column and several keymaps
    "kshenoy/vim-signature",
    cond = not vim.g.vscode,
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    -- Change background highlight to match color of string, e.g. '#abf4c2'
    "brenoprata10/nvim-highlight-colors",
    cond = not vim.g.vscode,
    event = "BufReadPost",
    config = true,
  },
  {
    -- Maximize window and restore
    "szw/vim-maximizer",
    cond = not vim.g.vscode,
    cmd = "MaximizerToggle",
    keys = {
      { "<F3>", mode = { "i", "n", "v" }, desc = "Toggle maximize window" },
    },
  },
}
