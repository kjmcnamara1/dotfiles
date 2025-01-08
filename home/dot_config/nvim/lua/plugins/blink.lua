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
    opts_extend = { "sources.compat", "sources.default" },
    opts = {
      -- TODO: add keymap <tab> for cmdline complete
      keymap = {
        ["<c-d>"] = { "scroll_documentation_down", "fallback" },
        ["<c-u>"] = { "scroll_documentation_up", "fallback" },
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
        default = { "lsp", "path", "snippets", "buffer" },
        compat = { "nerdfont", "emoji" },
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
