return {

  {
    "echasnovski/mini.ai",
    dependencies = 'echasnovski/mini.extra',
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      local gen_ai_spec = require('mini.extra').gen_ai_spec
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.inner" }), -- assignment
          m = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),     -- method / function definition
          c = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),       -- comment
          C = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),           -- class
          -- TODO: add textobject for indent
          Q = { "([\"'])%1%1.-%1%1%1", "^...().-()...$" },                                  -- balanced python triple quote
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },               -- tags
          e = {                                                                             -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          i = gen_ai_spec.indent(),
          d = gen_ai_spec.diagnostic(),
          L = gen_ai_spec.line(),
          N = gen_ai_spec.number(),
          B = gen_ai_spec.buffer(),                                  -- entire buffer
          F = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    -- config = function(_, opts)
    --   require("mini.ai").setup(opts)
    --   LazyVim.on_load("which-key.nvim", function()
    --     vim.schedule(function()
    --       LazyVim.mini.ai_whichkey(opts)
    --     end)
    --   end)
    -- end,
  },

  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
        width_focus = 40,
        width_preview = 30,
      },
      mappings = {
        close = "<esc>",
        synchronize = "<cr>",
      },
    },
    config = function(_, opts)
      require('mini.files').setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          Snacks.rename.on_rename_file(event.data.from, event.data.to)
        end,
      })
    end
  },

  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },

  -- {
  --   'echasnovski/mini.pick',
  --   opts = {},
  -- },

  {
    'echasnovski/mini.splitjoin',
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    opts = {
      n_lines = 30,
      mappings = {
        add = "ms",
        delete = "md",
        find = "mf",
        find_left = "mF",
        highlight = "mh",
        replace = "mr",
        update_n_lines = "mn",
      }
    }
  },

}
