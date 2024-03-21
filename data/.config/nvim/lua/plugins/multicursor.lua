return {
  {
    "mg979/vim-visual-multi",
    cond = not vim.g.vscode,
    cmd = { "VMClear", "VMDebug", "VMFromSearch", "VMLive", "VMRegisters", "VMSearch", "VMTheme" },
    keys = {
      { "<c-n>",                    desc = "MultiCursor select word" },
      { "<c-down>",                 desc = "add MultiCursor above" },
      { "<c-up>",                   desc = "add MultiCursor below" },
      { "<s-left>",                 desc = "MultiCursor select left" },
      { "<s-right>",                desc = "MultiCursor select right" },
      { "<bslash><bslash><bslash>", desc = "add MultiCursor" },
      { "<bslash><bslash>gS",       desc = "reselect last MultiCursor selection" },
      { "<bslash><bslash>A",        desc = "MultiCursor select all words in file",            mode = { "n", "x" } },
      { "<bslash><bslash>/",        desc = "MultiCursor start regex search",                  mode = { "n", "x" } },
      { "<c-n>",                    desc = "MultiCursor select",                              mode = "x" },
      { "<bslash><bslash>a",        desc = "MultiCursor add visual selection",                mode = "x" },
      { "<bslash><bslash>f",        desc = "MultiCursor find all patterns from '/' register", mode = "x" },
      { "<bslash><bslash>c",        desc = "create column of MultiCursors",                   mode = "x" },
    },
    config = function()
      vim.cmd.VMTheme("nord")
    end,
  },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    cond = not not vim.g.vscode,
    event = "VeryLazy",
    opts = {},
  }
}
