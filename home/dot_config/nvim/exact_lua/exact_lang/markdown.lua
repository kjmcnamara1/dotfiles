return {

  {
    "OXY2DEV/markview.nvim",
    enabled = not vim.g.vscode,
    -- lazy = false, -- Recommended
    ft = "markdown", -- If you decide to lazy-load anyway

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
      -- "nvim-tree/nvim-web-devicons"
    }
  }

}
