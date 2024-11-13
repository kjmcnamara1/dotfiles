return {
  {
    "folke/noice.nvim",
    cond = not vim.g.vscode,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    event = "VeryLazy",
    keys = {
      -- NOTE: Can't close shell with CTRL-D
      --
      -- { "<c-d>",      "<cmd>NoiceDismiss<cr>", desc = "Dismiss All",        mode = { "i", "c", "t" } },
      { "<leader>ud", "<cmd>NoiceDismiss<cr>", desc = "Dismiss All", },
      { "<leader>ul", "<cmd>NoiceLast<cr>",    desc = "Noice Last Message", },
      { "<leader>uh", "<cmd>NoiceHistory<cr>", desc = "Noice History", },
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            find = "line %d+ of %d+"
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        -- long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    cond = not vim.g.vscode,
    opts = {
      timeout = 1000,
      max_height = function()
        return math.floor(vim.o.lines * 0.25)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.33)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      render = "wrapped-compact",
      -- stages = "static",
    },
    config = function(_, opts)
      local stages_util = require("notify.stages.util")
      opts.stages = {
        function(state)
          local next_height = state.message.height + 2
          local next_row = stages_util.available_slot(
            state.open_windows,
            next_height,
            stages_util.DIRECTION.BOTTOM_UP
          )
          if not next_row then
            return nil
          end
          return {
            relative = "editor",
            anchor = "NE",
            width = state.message.width,
            height = state.message.height,
            col = vim.opt.columns:get(),
            row = next_row,
            border = "rounded",
            style = "minimal",
            opacity = 0,
          }
        end,
        function()
          return {
            opacity = { 100 },
            col = { vim.opt.columns:get() },
          }
        end,
        function()
          return {
            col = { vim.opt.columns:get() },
            time = true,
          }
        end,
        function()
          return {
            width = {
              1,
              frequency = 2.5,
              damping = 0.9,
              complete = function(cur_width)
                return cur_width < 3
              end,
            },
            opacity = {
              0,
              frequency = 2,
              complete = function(cur_opacity)
                return cur_opacity <= 4
              end,
            },
            col = { vim.opt.columns:get() },
          }
        end,
      }

      require("notify").setup(opts)
    end
  },
  -- used for generic input and select (e.g. lsp code actions)
  -- noice will be used for IncRename
  {
    "stevearc/dressing.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      input = {
        insert_only = false,
      },
    },
  },
  -- prefer to use noice for IncRename
  {
    "smjonas/inc-rename.nvim",
    cond = not vim.g.vscode,
    cmd = "IncRename",
    keys = {
      {
        "<leader>cr",
        ":IncRename ",
        -- function()
        --   return ":IncRename " .. vim.fn.expand("<cword>")
        -- end,
        -- expr = true,
        desc = "LSP Rename",
        buffer = 0,
      },
    },
    opts = {
      -- input_buffer_type = "dressing",
    },
  },
}
