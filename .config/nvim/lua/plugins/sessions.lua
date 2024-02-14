return {
  {
    'rmagatti/auto-session',
    lazy = false,
    cmd = { 'SessionSave', 'SessionRestore', 'SessionRestoreFromFile', 'SessionDelete', 'Autosession' },
    keys = {
      {
        '<leader>ss',
        function()
          require('auto-session.session-lens').search_session()
        end,
        desc = 'Search session'
      }
    },
    opts = {
      session_lens = {
        load_on_setup = true,
        them_conf = { bofder = true },
      }
    }
  }
}
