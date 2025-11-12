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
    bigfile = {},
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
    notifier = {},
    explorer = {},
    picker = {
      layout = "left",
      sources = {
        buffers = { layout = "vscode" },
        keymaps = { layout = "select" },
        cliphist = { layout = "dropdown" },
        files = { hidden = true },
        grep = { hidden = true },
        explorer = { hidden = true, layout = { preview = "main" } },

        -- Custom Sources
        filetypes = {
          finder = function(_opts, _ctx)
            return vim.iter(vim.fn.getcompletion("", "filetype")):map(function(ft)
              return { text = ft }
            end):totable()
          end,
          format = function(item)
            local icon, icon_hl = Snacks.util.icon(item.text, "filetype")
            return {
              { icon or "", icon_hl or "SnacksPickerIcon" },
              { " ",        "" },
              { item.text,  "SnacksPickerLabel" },
            }
          end,
          confirm = function(picker, item)
            picker:close()
            vim.bo.filetype = item.text
          end,
          layout = {
            reverse = true,
            layout = {
              backdrop = false,
              row = -1,
              col = -1,
              box = "vertical",
              border = true,
              width = 20,
              height = 10,
              title = "{title}",
              { win = "list",  border = "none" },
              { win = "input", height = 1,     border = "top" },
            }
          },
        },

        chezmoi_files = {
          finder = function(_opts, _ctx)
            local czc = require('chezmoi.commands')
            local targets = czc.list({ args = { "--include=files", "--path-style=absolute" } })
            return vim.iter(targets):map(function(absolute)
              return { text = absolute, file = absolute }
            end):totable()
          end,
          confirm = function(picker, item)
            picker:close()
            local czc = require('chezmoi.commands')
            czc.edit({ targets = item.file, args = { "--watch" } })
          end,
        },

        nvim_options = {
          layout = "default",
          finder = function()
            local options = {}
            for name, info in pairs(vim.api.nvim_get_all_options_info()) do
              local ok, value = pcall(vim.api.nvim_get_option_value, name, {})
              if ok then
                info["type"] = info.type:gsub("^%l", string.upper)
                info["value"] = value
                table.insert(options, info)
              end
            end
            return options
          end,
          format = function(item, picker)
            -- local icon, icon_hl = Snacks.util.icon(item.type, "kind")
            -- local icons = {}
            -- for k, v in pairs(picker.opts.icons.kinds) do
            --   icons[k:lower()] = v
            -- end
            -- dd(item)
            return {
              { picker.opts.icons.kinds[item.type] or "", "SnacksPickerIcon" .. item.type },
              { " ", "" },
              { ("%-30s"):format(item.name), "SnacksPickerLabel" },
              { "│ ", "SnacksPickerCol" },
              { tostring(item.value), item.value == item.default and "SnacksPickerUnselected" or "SnacksPickerSelected" },
            }
          end,
        },
      },

      formatters = {
        file = {
          filename_first = true,
        },
      },

      win = {
        input = {
          keys = {
            ["<c-c>"] = { "stopinsert", mode = "i" },
            ["<esc>"] = { "cancel", mode = { "i", "n" } },
            -- ["<a-s-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            -- ["<a-h>"] = { "<left>", mode = { "n", "i" } },
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
          },
        },
      },

      actions = {
        stopinsert = function(_)
          vim.cmd.stopinsert()
        end,
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },

    },
    input = {},
    quickfile = {},
    statuscolumn = {},
    words = {},
    scroll = {
      enabled = false, -- breaks multi-cursor
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
      lazygit = {
        width = 0,
        height = 0,
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
        Snacks.toggle.zoom():map("<a-m>")
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
