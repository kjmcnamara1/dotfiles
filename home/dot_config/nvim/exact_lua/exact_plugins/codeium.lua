return {

  {
    "Exafunction/codeium.nvim",
    enabled = not vim.g.vscode,
    cmd = "Codeium",
    event = "InsertEnter",
    build = ":Codeium Auth",
    opts = {
      virtual_text = {
        enabled = true,
        key_bindings = {
          -- accept = false, -- handled by nvim-cmp / blink.cmp
          --   next = "<M-]>",
          --   prev = "<M-[>",
        },
      },
    },
  },

  -- TODO: don't integrate with blink
  -- set separate keybind for accept
  -- change highlight group to distinguish from blink completions
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        compat = { "codeium" },
        providers = {
          codeium = {
            -- kind = "Codeium",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  }

}
