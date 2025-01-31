return {

  {
    "Exafunction/codeium.nvim",
    enabled = not vim.g.vscode,
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        -- idle_delay = 0,
        accept_fallback = "<right>",
        key_bindings = {
          -- accept = false, -- handled by nvim-cmp / blink.cmp
          accept = "<a-l>",
          accept_word = "<c-l>",
          accept_line = "<c-j>",
          --   next = "<M-]>",
          --   prev = "<M-[>",
        },
      },
    },
    config = function(_, opts)
      require("codeium").setup(opts)
      -- HACK: to force `require("codeium.virtual_text").set_style()`
      vim.cmd([[do ColorScheme]])
    end
  },

  -- {
  --   "saghen/blink.cmp",
  --   opts = {
  --     sources = {
  --       compat = { "codeium" },
  --       providers = {
  --         codeium = {
  --           -- kind = "Codeium",
  --           score_offset = 100,
  --           async = true,
  --         },
  --       },
  --     },
  --   },
  -- },

}
