-- ================================================================================
-- * Which Key
-- ================================================================================

return {
  "folke/which-key.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  keys = { { "<leader>?", function() require("which-key").show() end, desc = "Keymaps (which-key)" } },
  opts = { preset = "helix" },
}
