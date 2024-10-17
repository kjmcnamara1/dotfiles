-- TODO: Plugin Configs
-- debuggers (nvim-dap,nvim-dap-ui,nvim-dap-python,debugpy)
-- Codeium
-- vs-code integration

return {
  -- ====================================== COLORSCHEMES ======================================
  -- ============================================ UI ============================================
  -- {
  --   "nvimdev/dashboard-nvim",
  --   event = "VimEnter",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   opts = function()
  --     local logo = [[
  --       ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
  --       ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
  --       ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
  --       ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
  --       ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
  --       ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
  --     ]]
  --     logo = string.rep("\n", 8) .. logo .. "\n\n"

  --     local opts = {
  --       theme = "doom",
  --       config = {
  --         header = vim.split(logo, "\n"),
  --         center = {
  --           { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
  --           { action = "ene | startinsert", desc = " New file", icon = " ", key = "n" },
  --           { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
  --           { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
  --           {
  --             action = [[lua require("telescope.builtin").find_files({cwd = vim.fn.stdpath("config")})]],
  --             desc = " Config",
  --             icon = " ",
  --             key = "c",
  --           },
  --           { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
  --           -- { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
  --           { action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
  --           { action = "qa", desc = " Quit", icon = " ", key = "q" },
  --         },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --         end,
  --       },
  --     }

  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       button.key_format = "  %s"
  --     end

  --     -- close Lazy and re-open when the dashboard is ready
  --     if vim.o.filetype == "lazy" then
  --       vim.cmd.close()
  --       vim.api.nvim_create_autocmd("User", {
  --         pattern = "DashboardLoaded",
  --         callback = function()
  --           require("lazy").show()
  --         end,
  --       })
  --     end

  --     return opts
  --   end,
  -- },
  -- {
  --   "j-hui/fidget.nvim",
  --   opts = {
  --     -- options
  --   },
  -- },

  -- ============================================ EDITOR ============================================

  -- ============================================ EDITING ============================================
  -- {
  --   "echasnovski/mini.pairs",
  --   event = "VeryLazy",
  --   config = true,
  -- },



}
