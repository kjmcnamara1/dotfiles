-- ================================================================================
-- * Fuzzy Finder
-- ================================================================================

return {

  {
    "ibhagwan/fzf-lua",
    enabled = not vim.g.vscode,
    dependencies = { "echasnovski/mini.icons" },
    event = "VeryLazy",
    cmd = "FzfLua",
    opts = {
      "borderless_full",
      fzf_colors = {
        true,
        ["gutter"] = { "bg", "PmenuSbar" },
      },
      defaults = {
        formatter = "path.filename_first",
        prompt = " ",
        -- prompt = " ",
      },
      keymap = {
        builtin = {
          true,
          ["<Esc>"] = "hide",
        },
        fzf = {
          true,
          ["ctrl-d"] = "half-page-down",
          ["ctrl-u"] = "half-page-up",
          ["ctrl-x"] = "jump",
        },
      },
      previewers = {
        builtin = {
          extensions = {
            -- ["jpg"] = { "ueberzug" },
            ["png"] = { "chafa", "{file}", "--format=symbols" },
            ["jpg"] = { "chafa", "{file}", "--format=symbols" },
            ["jpeg"] = { "chafa", "{file}", "--format=symbols" },
            ["gif"] = { "chafa", "{file}", "--format=symbols" },
            ["webp"] = { "chafa", "{file}", "--format=symbols" },
            ["svg"] = { "chafa", "{file}", "--format=symbols" },
            -- ["jpg"] = { "viu", "-b" },
          },
          ueberzug_scaler = "fit_contain",
          -- ueberzug_scaler = "cover",
        },
      },
      winopts = {
        width = .7,
        height = .5,
        row = .5,
        col = .5,
        preview = {
          -- scrollbar = "border",
          scrollchars = { "┃", "" }, -- doesn't do anything
          winopts = {
            number = false,
          },
        },
      },
      lsp = {
        symbols = {
          symbol_style = 2,
          symbol_fmt = function(s, opts) return s end,
        },
        code_actions = {
          prompt = " ",
          previewer = "codeaction_native",
          winopts = {
            width = .5,
            preview = {
              layout = 'vertical',
              vertical = 'down:15,border-top',
            },
          }
        },
      },
      ui_select = function(opts, items)
        local select_opts = {
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
            width = .5,
            height = math.floor(math.min(vim.o.lines * .8, #items + 2) + .5),
          },
        }
        return select_opts
      end,
    },
    config = function(_, opts)
      local actions = require("fzf-lua").actions
      -- use the same prompt for all pickers for profile `default-title` and
      -- profiles that use `default-title` as base profile
      local function fix(t)
        t.prompt = t.prompt ~= nil and opts.defaults.prompt or nil
        for _, v in pairs(t) do
          if type(v) == "table" then
            fix(v)
          end
        end
        return t
      end
      opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts, {
        files = {
          actions = {
            ["alt-i"] = actions.toggle_ignore,
            ["alt-h"] = actions.toggle_hidden,
            -- ["ctrl-g"] = {},
          }
        },
        grep = {
          actions = {
            ["alt-i"] = actions.toggle_ignore,
            ["alt-h"] = actions.toggle_hidden,
          },
        }
      })
      -- vim.print(opts.ui_select)
      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select(opts.ui_select or nil)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    cond = not vim.g.vscode,
    version = false,
    cmd = "Telescope",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        enabled = vim.fn.executable("make") == 1,
      }
    },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "   ",
        entry_prefix = "    ",
        multi_icon = "   ",
        dynamic_preview_title = true,
        file_ignore_patterns = { "^%.git/", "%.jpg$" },
        -- hidden = true,
        sorting_strategy = "ascending",
        -- winblend = 20,
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        -- -- include hidden files in live_grep
        -- vimgrep_arguments = {
        --   "rg",
        --   "--color=never",
        --   "--no-heading",
        --   "--with-filename",
        --   "--line-number",
        --   "--column",
        --   "--smart-case",
        --   "--hidden",
        -- },
        mappings = {
          i = {
            ["<c-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<c-l>"] = false,
            ['<esc>'] = "close",
          },
          -- n = {
          --   ["<c-c>"] = "close",
          -- },
        },
      },
      pickers = {
        find_files = {
          -- include hidden files but not .git dir
          -- find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          hidden = true,
        },
        live_grep = {
          additional_args = { '--hidden' },
        },
        oldfiles = {
          theme = "dropdown",
        },
        -- grep_string = {
        --   -- include hidden files but not .git dir
        --   find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        -- },
        command_history = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          -- layout_strategy = 'center',
          previewer = false,
          ignore_current_buffer = true,
          sort_mru = true,
          sort_lastused = true,
          layout_config = {
            anchor = "N",
          },
          mappings = {
            i = {
              ["<a-c>"] = "delete_buffer",
            },
            -- n = {
            --   x = "delete_buffer",
            -- },
          },
        },
        colorscheme = {
          enable_preview = true,
          layout_strategy = "vertical",
          layout_config = {
            anchor = "SE",
            width = 30,
            height = 20,
            preview_height = 1,
            prompt_position = "bottom",
          }
        },
        filetypes = {
          layout_config = {
            anchor = "SE",
            width = 30,
            height = 10,
            prompt_position = "bottom",
          },
        },
        diagnostics = {
          theme = "ivy",
        },
        -- symbols = {
        --   theme = "cursor",
        --   layout_config = { width = 50 },
        -- },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      }
    },
    config = function(_, opts)
      local telescope = require("telescope")

      telescope.setup(opts)
      -- if vim.fn.executable("make") == 1 then
      telescope.load_extension("fzf")
      -- end
    end,
  }

}
