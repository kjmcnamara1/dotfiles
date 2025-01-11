return {

  {
    "saghen/blink.cmp",
    dependencies = {
      { "saghen/blink.compat", version = "*" },
      "rafamadriz/friendly-snippets", -- useful snippets
      "chrisgrieser/cmp-nerdfont",    -- nerd font icons
      -- "hrsh7th/cmp-emoji",            -- emoji
      "moyiz/blink-emoji.nvim",
    },
    version = "*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts_extend = { "sources.compat", "sources.default" },
    opts = {
      keymap = {
        preset = "default",
        ["<c-d>"] = { "scroll_documentation_down", "fallback" },
        ["<c-u>"] = { "scroll_documentation_up", "fallback" },
        cmdline = {
          preset = "super-tab",
        },
      },
      completion = {
        accept = {
          auto_brackets = { enabled = true }, -- doesn't seem to work
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        compat = { "nerdfont" },
        providers = {
          emoji = {
            name = "Emoji",
            module = "blink-emoji",
          },
        },
      },
    },
    config = function(_, opts)
      -- Add blink.compat providers
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend("force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end
      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil
      require("blink.cmp").setup(opts)
    end
  }

}
