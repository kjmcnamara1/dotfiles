return {
  "nvim-lualine/lualine.nvim",
  enabled = not (vim.g.vscode or vim.env.KITTY_SCROLLBACK_NVIM == "true"),
  dependencies = {
    "echasnovski/mini.icons",
    -- "folke/noice.nvim",
  },
  event = "VeryLazy",
  opts = {
    options = {
      globalstatus = true,
      disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " "
          }
        },
        "diagnostics"
      },
      lualine_c = {
        {
          function()
            return "󱉭 " .. vim.fs.basename(vim.uv.cwd())
          end,
          color = function()
            return { fg = Snacks.util.color("Special") }
          end
        },
        {
          "filename",
          newfile_status = true,
          path = 1,
          symbols = {
            modified = " ",
            readonly = " ",
            unnamed = "No Name  ",
            newfile = "New  "
          }
        }
      },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" }
    },
  },
  -- init = function()
  --   vim.g.lualine_laststatus = vim.o.laststatus
  --   if vim.fn.argc(-1) > 0 then
  --     -- set an empty statusline till lualine loads
  --     vim.o.statusline = " "
  --   else
  --     -- hide the statusline on the starter page
  --     vim.o.laststatus = 0
  --   end
  -- end
}
