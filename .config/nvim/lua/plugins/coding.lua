
return {
  {
    "echasnovski/mini.basics",  
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
    "echasnovski/mini.cursorword",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.surround",
    keys = { 
      { 'sa',desc='Add surrounding', mode={'n','x'} },
      { 'sd',desc='Delete surrounding',  },
      { 'sr',desc='Replace surrounding',  },
      { 'sh',desc='Highlight surrounding',  },
      { 'sf',desc='Find right surrounding',  },
      { 'sF',desc='Find left surrounding',  },
      { 'sn',desc='Update `MiniSurround.config.n_lines`',  },
    },
    config=true,
    init=function()
      vim.keymap.set('n','s','<nop>')
    end,
  },
}
