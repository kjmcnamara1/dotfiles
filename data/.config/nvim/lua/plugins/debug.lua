return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
    },
    cond = not vim.g.vscode,
    keys = {
      { "n", "<leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "n", "<leader>dc", function() require("dap").continue() end,          desc = "Continue Debug" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint)
      -- vim.keymap.set("n", "<leader>dc", dap.continue)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    cond = not vim.g.vscode,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    cmd = "VenvSelect",
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv", }
    },
    opts = {
      auto_refresh = true,
      dap_enabled = true,
      name = { "venv", ".venv", "env", ".env", },
      -- poetry_path = "~/.cache/pypoetry/virtualenvs",
    },
    config = function(_, opts)
      require("venv-selector").setup(opts)

      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Auto select virtualenv Nvim open",
        pattern = "*",
        callback = function()
          local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
          if venv ~= "" then
            require("venv-selector").retrieve_from_cache()
          end
        end,
        once = true,
      })
    end

  },
}
