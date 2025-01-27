-- ================================================================================
-- * Snacks
-- ================================================================================

return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  priority = 1000,
  lazy = false,
  opts = {
    -- animate = { easing = 'quadratic' },
    bigfile = { enabled = true },
    indent = {
      enabled = true,
      char = "┊",
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
        "SnacksIndent5",
        "SnacksIndent6",
        "SnacksIndent7",
        "SnacksIndent8",
        "SnacksIndent9",
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          arrow = '󰅂',
          -- arrow = '─',
        },
      },
    },
    notifier = { enabled = true },
    input = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 100 },
        easing = 'inOutCubic',
      },
    },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      },
      notification_history = {
        keys = { ['<esc>'] = 'close' },
      },
    },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "keys" --[[ , gap = 1 ]], padding = 1 },
        { section = "projects", icon = " ", title = "Projects", padding = 2, indent = 2 },
        { section = "startup" },
      },
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          {
            icon = " ",
            key = "N",
            desc = "Neovim News",
            action = function()
              Snacks.win({
                file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                width = 0.6,
                height = 0.6,
                wo = {
                  spell = false,
                  wrap = false,
                  signcolumn = "yes",
                  statuscolumn = " ",
                  conceallevel = 3,
                },
              })
            end
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    -- zen = {
    --   win = {
    --     minimal = true,
    --     backdrop = {
    --       bg = "#3b4252",
    --       transparent = false,
    --     },
    --   },
    --   toggles = {
    --     dim = true,
    --     git_signs = true,
    --     mini_diff_signs = true,
    --     line_number = false,
    --     diagnostics = true,
    --     inlay_hints = false,
    --   },
    -- }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.animate():map("<leader>ua")
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.dim():map("<leader>uD")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map(
          "<leader>uc")
        Snacks.toggle.option("showtabline", { off = 0, on = 2, name = "Bufferline" }):map("<leader>uB")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>uI")
        Snacks.toggle.zoom():map("<leader>wm")
        -- Snacks.toggle.zen():map("<leader>uz")
        Snacks.toggle({
          name = "Git Signs",
          get = function()
            return require("gitsigns.config").config.signcolumn
          end,
          set = function(state)
            require("gitsigns").toggle_signs(state)
          end,
        }):map("<leader>uG")

        -- Snacks.toggle.profiler():map("<leader>dpp")
        -- Snacks.toggle.profiler_highlights():map("<leader>dph")

        -- Create Indent Colors
        local theme_colors = require("onenord.colors").load()

        local blend_colors = function(base, tint, amount)
          base = base:gsub("#", "")
          base = { tonumber(base:sub(1, 2), 16), tonumber(base:sub(3, 4), 16), tonumber(base:sub(5, 6), 16) }
          tint = tint:gsub("#", "")
          tint = { tonumber(tint:sub(1, 2), 16), tonumber(tint:sub(3, 4), 16), tonumber(tint:sub(5, 6), 16) }
          local result = "#"
          for i = 1, #base do
            result = result .. string.format("%02x", base[i] + amount * (tint[i] - base[i]))
          end
          return result
        end

        for i, color in ipairs({ 'red', 'yellow', 'blue', 'orange', 'green', 'purple', 'cyan', 'pink' }) do
          vim.api.nvim_set_hl(0, "SnacksIndent" .. i,
            { bg = blend_colors(theme_colors.bg, theme_colors[color], 0.05) })
        end
      end,
    })
  end,
}
