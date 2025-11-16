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
  keys = {
    -- Top Pickers & Explorer
    { "<leader>pp",      function() Snacks.picker.pickers() end,                                                desc = "Pick: Pickers" },
    { "<leader><space>", function() Snacks.picker.smart() end,                                                  desc = "Pick: Smart Files" },
    { "<leader>,",       function() Snacks.picker.buffers() end,                                                desc = "Pick: Buffers" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                                   desc = "Pick: Grep" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                                        desc = "Pick: Command History" },
    { "<leader>e",       function() Snacks.explorer() end,                                                      desc = "Pick: File Explorer" },
    -- find
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                desc = "Pick: Config Files" },
    { "<leader>fz",      function() Snacks.picker.chezmoi_files() end,                                          desc = "Pick: Chezmoi File" },
    { "<leader>ff",      function() Snacks.picker.files() end,                                                  desc = "Pick: Files" },
    { "<leader>fg",      function() Snacks.picker.git_files() end,                                              desc = "Pick: Git Files" },
    { "<leader>fp",      function() Snacks.picker.projects() end,                                               desc = "Pick: Projects" },
    { "<leader>fr",      function() Snacks.picker.recent() end,                                                 desc = "Pick: Recent" },
    { "<leader>ft",      function() Snacks.picker.filetypes() end,                                              desc = "Pick: Filetypes", },
    -- git
    { "<leader>gb",      function() Snacks.picker.git_branches() end,                                           desc = "Pick: Git Branches" },
    { "<leader>gc",      function() Snacks.picker.git_log() end,                                                desc = "Pick: Git Log (Commits)" },
    { "<leader>gL",      function() Snacks.picker.git_log_line() end,                                           desc = "Pick: Git Log Line" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,                                             desc = "Pick: Git Status" },
    { "<leader>gS",      function() Snacks.picker.git_stash() end,                                              desc = "Pick: Git Stash" },
    { "<leader>gd",      function() Snacks.picker.git_diff() end,                                               desc = "Pick: Git Diff (Hunks)" },
    { "<leader>gf",      function() Snacks.picker.git_log_file() end,                                           desc = "Pick: Git Log File" },
    -- GitHub
    { "<leader>ghi",     function() Snacks.picker.gh_issue() end,                                               desc = "Pick: GitHub Issues (open)" },
    { "<leader>ghI",     function() Snacks.picker.gh_issue({ state = "all" }) end,                              desc = "Pick: GitHub Issues (all)" },
    { "<leader>ghp",     function() Snacks.picker.gh_pr() end,                                                  desc = "Pick: GitHub Pull Requests (open)" },
    { "<leader>ghP",     function() Snacks.picker.gh_pr({ state = "all" }) end,                                 desc = "Pick: GitHub Pull Requests (all)" },
    -- grep
    { "<leader>sb",      function() Snacks.picker.lines() end,                                                  desc = "Pick: Buffer Lines" },
    { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                                           desc = "Pick: Grep Open Buffers" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,                                              desc = "Pick: Visual selection or word",   mode = { "n", "x" } },
    -- search
    { '<leader>s"',      function() Snacks.picker.registers() end,                                              desc = "Pick: Registers" },
    { '<leader>s/',      function() Snacks.picker.search_history() end,                                         desc = "Pick: Search History" },
    { "<leader>sa",      function() Snacks.picker.autocmds() end,                                               desc = "Pick: Autocmds" },
    { "<leader>sc",      function() Snacks.picker.commands() end,                                               desc = "Pick: Commands" },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                            desc = "Pick: Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                                     desc = "Pick: Buffer Diagnostics" },
    { "<leader>sh",      function() Snacks.picker.help() end,                                                   desc = "Pick: Help Pages" },
    { "<leader>sH",      function() Snacks.picker.highlights() end,                                             desc = "Pick: Highlights" },
    { "<leader>si",      function() Snacks.picker.icons() end,                                                  desc = "Pick: Icons" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                                  desc = "Pick: Jumps" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                                desc = "Pick: Keymaps" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                                                  desc = "Pick: Marks" },
    { "<leader>sM",      function() Snacks.picker.man() end,                                                    desc = "Pick: Man Pages" },
    { "<leader>sO",      function() Snacks.picker.nvim_options() end,                                           desc = "Pick: Neovim Options" },
    { "<leader>sp",      function() Snacks.picker.lazy() end,                                                   desc = "Pick: Search for Plugin Spec" },
    { "<leader>sq",      function() Snacks.picker.qflist() end,                                                 desc = "Pick: Quickfix List" },
    { "<leader>sl",      function() Snacks.picker.loclist() end,                                                desc = "Pick: Location List" },
    { "<leader>st",      function() Snacks.picker.todo_comments() end,                                          desc = "Pick: Todo" },
    { "<leader>sT",      function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end, desc = "Pick: Todo/Fix/Fixme" },
    { "<leader>sR",      function() Snacks.picker.resume() end,                                                 desc = "Pick: Resume" },
    { "<leader>su",      function() Snacks.picker.undo() end,                                                   desc = "Pick: Undo History" },
    { "<leader>sy",      function() Snacks.picker.cliphist() end,                                               desc = "Pick: Clipboard" },
    { "<leader>uC",      function() Snacks.picker.colorschemes() end,                                           desc = "Pick: Colorschemes" },
    -- LSP
    { "gd",              function() Snacks.picker.lsp_definitions() end,                                        desc = "LSP: Goto Definition" },
    { "grd",             function() Snacks.picker.lsp_declarations() end,                                       desc = "LSP: Goto Declaration" },
    { "grr",             function() Snacks.picker.lsp_references() end,                                         desc = "LSP: References",                  nowait = true },
    { "gri",             function() Snacks.picker.lsp_implementations() end,                                    desc = "LSP: Goto Implementation" },
    { "grt",             function() Snacks.picker.lsp_type_definitions() end,                                   desc = "LSP: Goto Type Definition" },
    { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                                     desc = "LSP: C[a]lls Incoming" },
    { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                                     desc = "LSP: C[a]lls Outgoing" },
    { "go",              function() Snacks.picker.lsp_symbols() end,                                            desc = "LSP: Symbols" },
    { "gO",              function() Snacks.picker.lsp_workspace_symbols() end,                                  desc = "LSP: Workspace Symbols" },
    { "grf",             function() Snacks.rename.rename_file() end,                                            desc = "LSP: Rename File" },


    { "<leader>.",       function() Snacks.scratch() end,                                                       desc = "Toggle Scratch Buffer" },
    { "<leader>S",       function() Snacks.scratch.select() end,                                                desc = "Select Scratch Buffer" },

    { "<leader>n",       function() Snacks.notifier.hide() end,                                                 desc = "Notifications: Dismiss All" },
    { "<leader>N",       function() Snacks.notifier.show_history() end,                                         desc = "Notifications: History" },
    { "<leader>sn",      function() Snacks.picker.notifications() end,                                          desc = "Pick: Search Notifications" },

    { "<leader>bd",      function() Snacks.bufdelete() end,                                                     desc = "Delete Buffer" },
    { "<a-c>",           function() Snacks.bufdelete() end,                                                     desc = "Delete Buffer" },
    { "<leader>gB",      function() Snacks.gitbrowse() end,                                                     desc = "Git Browse" },
    { "<leader>gb",      function() Snacks.git.blame_line() end,                                                desc = "Git Blame Line" },
    { "<leader>gF",      function() Snacks.lazygit.log_file() end,                                              desc = "Lazygit Current File History" },
    { "<leader>gg",      function() Snacks.lazygit() end,                                                       desc = "Lazygit" },
    { "<leader>gl",      function() Snacks.lazygit.log() end,                                                   desc = "Lazygit Log (cwd)" },
    { "<c-'>",           function() Snacks.terminal() end,                                                      desc = "Toggle Terminal",                  mode = { "n", "i", "t" } },
    { "<a-t>",           function() Snacks.terminal() end,                                                      desc = "Toggle Terminal",                  mode = { "n", "i", "t" } },
    -- { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,                                        desc = "Next Reference",                   mode = { "n", "t" } },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                                       desc = "Prev Reference",                   mode = { "n", "t" } },
    -- { "<leader>dps", function() Snacks.profiler.scratch() end,        desc = "Profiler Scratch Bufer" },
  },
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
