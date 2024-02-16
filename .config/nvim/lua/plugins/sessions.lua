return {
  {
    "rmagatti/auto-session",
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
      pre_save_cmds = { "Neotree close", "TroubleClose" },
    }
  }
}
