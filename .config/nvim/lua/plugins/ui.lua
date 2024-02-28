return {
  {
    -- Adds labels for marks to sign column and several keymaps
    "kshenoy/vim-signature",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    -- Change background highlight to match color of string, e.g. '#abf4c2'
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPost",
    -- event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    -- Maximize window and restore
    "szw/vim-maximizer",
    cmd = "MaximizerToggle",
    keys = {
      { "<F3>", mode = { "i", "n", "v" }, desc = "Toggle maximize window" },
    },
  },
}
