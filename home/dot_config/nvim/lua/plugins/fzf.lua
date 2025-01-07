-- ================================================================================
-- * Fuzzy Finder
-- ================================================================================
-- TODO: Replace with FzfLua

return {

  {
    "ibhagwan/fzf-lua",
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
        },
      },
      winopts = {
        width = .5,
        height = .5,
        row = .5,
        col = .5,
        preview = {
          -- scrollbar = "border",
          scrollchars = { "┃", "" },
          winopts = {
            number = false,
          },
        },
      },
      ui_select = function(fzf_opts, items)
        return vim.tbl_deep_extend("force", fzf_opts, {
          -- prompt = " ",
          prompt = " ",
          winopts = {
            title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
            title_pos = "center",
            width = .5,
          },
        }, fzf_opts.kind == "codeaction" and {
          winopts = {
            -- height is number of items minus 15 lines for the preview, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * .8 - 16, #items + 2) + .5) + 16,
          }
        } or {
          winopts = {
            -- height is number of items, with a max of 80% screen height
            height = math.floor(math.min(vim.o.lines * .8, #items + 2) + .5),
          }
        })
      end,
    },
    config = function(_, opts)
      local actions = require('fzf-lua').actions
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

      require('fzf-lua').setup(opts)
      require('fzf-lua').register_ui_select(opts.ui_select or nil)
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    -- enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        -- build = 'make',
      },
    },
    cmd = "Telescope",
    -- keys = {
    --   { "<leader><space>", "<cmd>Telescope resume<cr>",      desc = "Resume" },
    --   { "<leader>ff",      "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
    --   { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },
    --   { "<leader>fb",      "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
    --   { "<leader>fg",      "<cmd>Telescope live_grep<cr>",   desc = "Search in CWD" },
    --   { "<leader>sh",      "<cmd>Telescope help_tags<cr>",   desc = "Help Pages" },
    --   { "<leader>sH",      "<cmd>Telescope highlights<cr>",  desc = "Search Highlight Groups" },
    --   { "<leader>sk",      "<cmd>Telescope keymaps<cr>",     desc = "Key Maps" },
    --   { "<leader>so",      "<cmd>Telescope vim_options<cr>", desc = "Options" },
    -- },
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "   ",
        entry_prefix = "    ",
        multi_icon = "   ",
        dynamic_preview_title = true,
        file_ignore_patterns = { "^%.git/", "%.jpg$" },
        sorting_strategy = "ascending",
        -- winblend = 20,
        layout_strategy = "flex",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<c-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<c-l>"] = false,
            ["<esc>"] = "close",
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- theme = "dropdown",
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
        oldfiles = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
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
          },
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  }

}
