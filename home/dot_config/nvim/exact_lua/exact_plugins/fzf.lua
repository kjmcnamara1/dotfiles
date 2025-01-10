-- ================================================================================
-- * Fuzzy Finder
-- ================================================================================

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
        width = .6,
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

      require("fzf-lua").setup(opts)
      require("fzf-lua").register_ui_select(opts.ui_select or nil)
    end,
  },

}
