return {
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
      -- symbol = "▏",
      symbol = "│",
      draw = {
        animation = function() return 0 end,
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
    enabled = false,
    main = "ibl",
    event = "VeryLazy",
    cond = vim.env.COMPUTERNAME ~= "ANGEL" and not vim.g.vscode,
    opts = {
      indent = { char = "" },
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
    config = function(_, opts)
      local theme_colors = require("onenord.colors").load()

      local blend_colors = function(base, tint, amount)
        base = base:gsub("#", "")
        base = { tonumber(base:sub(1, 2), 16), tonumber(base:sub(3, 4), 16), tonumber(base:sub(5, 6), 16) }
        tint = tint:gsub("#", "")
        tint = { tonumber(tint:sub(1, 2), 16), tonumber(tint:sub(3, 4), 16), tonumber(tint:sub(5, 6), 16) }
        local result = "#"
        for i = 1, #base do
          result = result .. string.format("%02x", base[i] + amount * (tint[i] - base[i]))
        end
        return result
      end

      local colors = { "Red", "Yellow", "Blue", "Orange", "Green", "Purple", "Cyan" }
      local highlight = {}

      for _, color in ipairs(colors) do
        local hl = "Ibl" .. color
        vim.api.nvim_set_hl(0, hl, { bg = blend_colors(theme_colors.bg, theme_colors[color:lower()], 0.05) })
        table.insert(highlight, hl)
      end

      opts.whitespace = { highlight = highlight, remove_blankline_trail = false }

      require("ibl").setup(opts)
    end
  },
}
