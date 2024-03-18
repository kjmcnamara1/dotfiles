return {
  {
    "echasnovski/mini.basics",
    enabled = false,
    event = "VeryLazy",
    opts = {
      options = {
        extra_ui = true,
      },
      mappings = {
        windows = true,
      },
    },
  },
  {
    -- Underline all other occurrences of word under cursor
    "echasnovski/mini.cursorword",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    config = true,
  },
  {
    -- Surroundings
    "echasnovski/mini.surround",
    keys = {
      { "sa", desc = "Add surrounding",                      mode = { "n", "x" } },
      { "sd", desc = "Delete surrounding", },
      { "sr", desc = "Replace surrounding", },
      { "sh", desc = "Highlight surrounding", },
      { "sf", desc = "Find right surrounding", },
      { "sF", desc = "Find left surrounding", },
      { "sn", desc = "Update `MiniSurround.config.n_lines`", },
    },
    config = true,
    init = function()
      vim.keymap.set("n", "s", "<nop>")
    end,
  },
  {
    -- Highlight current indent level
    "echasnovski/mini.indentscope",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      symbol = "▏",
      -- symbol = "│",
      draw = {
        animation = function()
          return 0
        end,
      },
      options = {
        try_as_border = true,
      },
    },
    init = function()
      -- Automatically disable mini.indentscope for certain filetypes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    -- Draw indent characters even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    -- cond = (vim.env.NAME or vim.env.COMPUTERNAME) ~= "ANGEL",
    cond = vim.env.COMPUTERNAME == "ANGEL" and not vim.g.vscode,
    opts = {
      indent = {
        char = "",
        tab_char = "│",
      },
      whitespace = {
        highlight = {
          "CursorColumn",
          "Whitespace",
        },
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
  },
}
