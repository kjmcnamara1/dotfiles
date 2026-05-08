return {

  -- TODO: add sign for GitSigns
  {
    "dstein64/nvim-scrollview",
    opts = {
      current_only = true,
      signs_scrollbar_overlap = "over",
      -- signs_max_per_row = 1,
      diagnostics_hint_symbol = "󱐋",
      diagnostics_info_symbol = "",
      diagnostics_warn_symbol = "󱈸",
      diagnostics_error_symbol = "",
      keywords_fix_symbol = "󰃤",
      keywords_hack_symbol = "󰈸",
      keywords_todo_symbol = "󰄬",
      signs_on_startup = {
        "conflicts",
        "diagnostics",
        "folds",
        "keywords",
        "latestchange",
        "loclist",
        "quickfix",
        "search",
        "spell",
        "indent",
        "trail",
      },
    },
    config = function(_, opts)
      require("scrollview").setup(opts)
      vim.api.nvim_set_hl(0, "ScrollViewKeywordsFix", { link = "TodoSignFIX" })
      vim.api.nvim_set_hl(0, "ScrollViewKeywordsHack", { link = "TodoSignHACK" })
      vim.api.nvim_set_hl(0, "ScrollViewKeywordsTodo", { link = "TodoSignTODO" })
    end
  },

}
