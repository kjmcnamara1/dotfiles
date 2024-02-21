return {
  {
    "rmagatti/auto-session",
    -- enabled = false,
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
      pre_save_cmds = { "Neotree close", "TroubleClose", --[[ "ScopeSaveState" ]] },
      -- post_restore_cmds = { "ScopeLoadState" },
    }
  },
  {
    "jedrzejboczar/possession.nvim",
    enabled=false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      autosave = {
        current = true,
      },
    },

  },
}
