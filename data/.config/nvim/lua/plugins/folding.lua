return {
  "kevinhwang91/nvim-ufo",
  cond = not vim.g.vscode,
  dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  cmd = { "UfoEnable", "UfoInspect", "UfoAttach", "UfoEnableFold", "UfoDisableFold" },
  keys = {
    -- { "zr", function() require("ufo").openFoldsExceptKinds() end,       desc = "Reduce fold level" },
    -- { "zm", function() require("ufo").closeFoldsWith() end,             desc = "Increase fold level" },
    -- { "zR", function() require("ufo").openAllFolds() end,               desc = "Open all folds" },
    -- { "zM", function() require("ufo").closeAllFolds() end,              desc = "Close all folds" },
    { "zK", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Preview folded text or LSP hover" },
    { "]z", function() require("ufo").goNextClosedFold() end,           desc = "Next fold" },
    { "[z", function() require("ufo").goPreviousClosedFold() end,       desc = "Previous fold" },
  },
  opts = {
    close_fold_kinds_for_ft = { "imports" },
    provider_selector = function(_bufnr, _filetype, _buftype)
      return { "treesitter", "indent" }
    end,
  },
  config = function(_, opts)
    require("ufo").setup(opts)
    -- Folding options for ufo plugin
    vim.opt.foldcolumn = "auto:9"
    vim.opt.foldlevel = 99
    -- vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
  end,
}
