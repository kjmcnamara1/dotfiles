return {

  -- ================================================================================
  -- * ColorScheme
  -- ================================================================================
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    name = "onenord",
    opts = {
      styles = {
        comments = "italic",
        keywords = "bold",
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onenord",
    },
  },
}
