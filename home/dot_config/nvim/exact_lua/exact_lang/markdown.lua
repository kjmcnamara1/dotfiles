return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.markdownlint_cli2,
      })
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    enabled = not vim.g.vscode,
    ft = "markdown", -- If you decide to lazy-load anyway
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
      -- "nvim-tree/nvim-web-devicons"
    },
    opts = {
      preview = {
        icon_provider = "mini",
        -- enable_hybrid_mode = true,
        -- linewise_hybrid_mode = true,
        -- hybrid_modes = { 'n' },
      },
      markdown_inline = {
        hyperlinks = {
          ["tel:"] = {
            icon = " ",
            hl = "MarkviewPalette2Fg",
          },
          ["maps.app.goo.gl/"] = {
            icon = "󰍎 ",
            hl = "MarkviewPalette1Fg",
          },
          ["mailto:"] = {
            icon = "󰇮 ",
            hl = "MarkviewPalette7Fg",
          },
        },
      },
    },
    config = function(_, opts)
      require("markview").setup(opts)
      require("markview.extras.checkboxes").setup()
      require("markview.extras.headings").setup()
    end
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = function(plugin)
      vim.cmd("!cd " .. plugin.dir .. " && cd app && ./install.sh")
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

}
