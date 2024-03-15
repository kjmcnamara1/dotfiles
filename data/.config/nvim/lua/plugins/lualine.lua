return {
  -- Status line
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/noice.nvim",
  },
  event = "VimEnter",
  opts = {
    options = {
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" }
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
          "filename",
          -- path = 4,
          symbols = {
            modified = " ",
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
    -- tabline = {
    --   lualine_a = { "buffers" },
    --   lualine_b = { "branch" },
    --   lualine_c = { "filename" },
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = { "tabs" }
    -- },
    -- winbar = {
    --   lualine_a = { "buffers" },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    -- inactive_winbar = {
    --   lualine_a = { "buffers" },
    --   lualine_b = {},
    --   lualine_c = {},
    --   lualine_x = {},
    --   lualine_y = {},
    --   lualine_z = {}
    -- },
    extensions = {
      "lazy",
      "mason",
      "toggleterm",
      "trouble",
    },
  },
  config = function(_, opts)
    local noice_opts = {
      require("noice").api.statusline.mode.get,
      cond = require("noice").api.statusline.mode.has,
      color = { fg = "orange" },
    }
    table.insert(opts.sections.lualine_x, 1, noice_opts)
    require("lualine").setup(opts)
  end
}
