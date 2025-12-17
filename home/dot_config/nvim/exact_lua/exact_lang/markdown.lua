return {

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettierd" },
      },
    },
  },

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
    keys = {
      { "<leader>um", "<cmd>Markview toggle<cr>",       desc = "Toggle Render Markdown",      ft = "markdown" },
      { "<leader>uM", "<cmd>Markview hybridToggle<cr>", desc = "Toggle Markview Hybrid Mode", ft = "markdown" },
      { "<c-t>",      "<cmd>Checkbox toggle<cr>",       desc = "Toggle Checkbox",             ft = "markdown" },
      { "<leader>cb", "<cmd>Checkbox interactive<cr>",  desc = "Interactive Checkbox",        ft = "markdown" },
      { "<c-right>",  "<cmd>Heading increase<cr>",      desc = "Increase Heading",            ft = "markdown" },
      { "<c-left>",   "<cmd>Heading decrease<cr>",      desc = "Decrease Heading",            ft = "markdown" },
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
    keys = {
      { "<leader>cp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview", ft = "markdown" },
    },
    build = function(plugin)
      vim.cmd("!cd " .. plugin.dir .. " && cd app && ./install.sh")
    end,
    config = function()
      vim.cmd([[do FileType]])
    end,
  },

}
