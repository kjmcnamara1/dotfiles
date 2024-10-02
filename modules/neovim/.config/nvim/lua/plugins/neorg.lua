return {
  "nvim-neorg/neorg",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "max397574/neorg-contexts",
    "3rd/image.nvim",
  },
  build = ":Neorg sync-parsers",
  ft = "norg",
  cmd = "Neorg",
  opts = {
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.summary"] = {},
      ["core.ui.calendar"] = {},
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = {      -- Manages Neorg workspaces
        config = {
          workspaces = {
            default = vim.fn.getcwd() .. "/notes",
            personal = "~/Notes",
          },
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp"
        },
      },
      ["core.presenter"] = {
        config = {
          zen_mode = "zen-mode"
        },
      },
      ["external.context"] = {},
    },
  },
  config = function(_, opts)
    require("neorg").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      desc = "Fix conceallevel for `norg` files",
      pattern = "norg",
      callback = function()
        vim.wo.conceallevel = 2
        -- vim.o.concealcursor = "nc"
      end
    })
  end
}
