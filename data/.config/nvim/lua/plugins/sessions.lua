return {
  {
    "rmagatti/auto-session",
    -- enabled = false,
    cond = not vim.g.vscode,
    dependencies = { "tiagovla/scope.nvim", config = true, },
    event = "VimEnter",
    cmd = { "SessionSave", "SessionRestore", "SessionRestoreFromFile", "SessionDelete", "Autosession" },
    keys = {
      {
        "<leader>ss",
        function()
          require("auto-session.session-lens").search_session()
        end,
        desc = "Sessions"
      }
    },
    opts = {
      -- auto_restore_enabled = false,
      session_lens = {
        load_on_setup = true,
      },
      pre_save_cmds = {
        "TroubleClose",
        -- "Neotree close",
        -- "ScopeSaveState"
      },
      -- post_restore_cmds = { "ScopeLoadState" },
    }
  },
}
