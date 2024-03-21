return {
  -- Status line
  "nvim-lualine/lualine.nvim",
  cond = not vim.g.vscode,
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
    --   lualine_a = {
    --     {
    --       "buffers",
    --       max_length = vim.o.columns,
    --       separator = { left = "", right = "" },
    --     },
    --   },
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
    -- Add 'macro recording' status
    local noice = require("noice")
    local noice_status = {
      noice.api.statusline.mode.get,
      cond = noice.api.statusline.mode.has,
      color = { fg = "orange" },
    }
    table.insert(opts.sections.lualine_x, 1, noice_status)

    -- Add clickable python venv selector
    local active_venv = function()
      local venv_name = require("venv-selector").get_active_venv()
      if venv_name ~= nil then
        return venv_name:gsub(".*/pypoetry/virtualenvs/", "(poetry) "):gsub("-.*-", "-")
      else
        return "venv"
      end
    end
    local venv = {
      function()
        return "  " .. active_venv()
      end,
      cond = function()
        return vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";") ~= ""
      end,
      on_click = function()
        vim.cmd.VenvSelect()
      end,
    }
    table.insert(opts.sections.lualine_x, 2, venv)

    -- Setup with custom sections
    require("lualine").setup(opts)
  end
}
