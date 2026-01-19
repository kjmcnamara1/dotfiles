return {

  {
    "sindrets/diffview.nvim",
    enabled = not vim.g.vscode,
    -- lazy = true,
    -- dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles' },
    opts = {},
  },

  {
    "clabby/difftastic.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("difftastic-nvim").setup({
        download = true, -- Auto-download pre-built binary
      })
    end,
  },

  {
    "ahkohd/difft.nvim",
    keys = {
      {
        "<leader>d",
        function()
          local Difft = require("difft")
          if Difft.is_visible() then
            Difft.hide()
          else
            Difft.diff()
          end
        end,
        desc = "Toggle Difft",
      },
    },
    opts = {
      command = "bash -c \"GIT_EXTERNAL_DIFF='difft --color=always' git diff\"", -- or "jj diff --no-pager"
      layout = "ivy_taller",                                                     -- nil (buffer), "float", or "ivy_taller"
    },
  },

}
