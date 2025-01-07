return {

  {
    "saghen/blink.cmp",
    dependencies = {
      { "saghen/blink.compat", version = "*" },
      "rafamadriz/friendly-snippets", -- useful snippets
      "chrisgrieser/cmp-nerdfont",    -- nerd font icons
      "hrsh7th/cmp-emoji",            -- emoji
    },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },
        ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
      },
      completion = {
        -- accept = {
        --   auto_brackets = { enabled = true }, -- doesn't seem to work
        -- },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      sources = {
        default = { "nerdfont", "emoji", },
        providers = {
          nerdfont = {
            name = "nerdfont",
            module = "blink.compat.source",
          },
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
          },
        },
      },
    },
  }

}
