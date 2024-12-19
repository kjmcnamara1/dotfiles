return {

  {
    "folke/snacks.nvim",
    keys = {
      { "<a-c>", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<c-'>", function() Snacks.terminal() end,  desc = "Toggle Terminal", mode = { 'n', 'i', 't' } },
    },
    opts = {
      zen = {
        win = {
          minimal = true,
          backdrop = {
            bg = "#3b4252",
            transparent = false,
          },
        },
        toggles = {
          dim = true,
          git_signs = true,
          mini_diff_signs = true,
          line_number = false,
          diagnostics = true,
          inlay_hints = false,
        },
        on_open = function(win)
          -- vim.diagnostic.config({ virtual_text = false })

          local stdout = vim.loop.new_tty(1, false)
          stdout:write(
            ("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format(
              "ZEN_MODE",
              vim.fn.system({ "base64" }, tostring("+2"))
            )
          )
          vim.cmd([[redraw]])
        end,
        on_close = function(win)
          local stdout = vim.loop.new_tty(1, false)
          stdout:write(
            ("\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\b\x1b\\"):format("ZEN_MODE", vim.fn.system({ "base64" }, "-1"))
          )
          vim.cmd([[redraw]])
        end
      }
    }
  },

  {
    -- Distraction free interface
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode", mode = { "n", "v" } }
    },
    opts = {
      window = {
        options = {
          -- signcolumn = "no",
          number = false,
          relativenumber = false,
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = "0",
          list = false,
          scrolloff = 999,
        }
      },
      plugins = {
        options = {
          enabled = true,
          laststatus = 0,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
        wezterm = { enabled = true, font = "+2" },
      },
    }
  }
}
