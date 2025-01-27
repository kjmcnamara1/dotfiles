return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        taplo = {
          root_dir = require("lspconfig.util").root_pattern("*.toml", ".git"),
        },
      },
    },
  },

  -- NOTE: Need to add .taplo.toml file in project
  -- [formatting]
  --   align_entries  = true
  --   indent_tables  = true
  --   indent_entries = true

}
