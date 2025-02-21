return {

  {
    "xvzc/chezmoi.nvim",
    enabled = not vim.g.vscode,
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua", },
    opts = { edit = { watch = true } },
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
        group = vim.api.nvim_create_augroup("chezmoi", { clear = true }),
        callback = function(event)
          local filename = vim.fs.basename(event.file)
          if vim.startswith(filename, 'run_') then -- exclude chezmoi run scripts
            return
          end
          vim.schedule(require("chezmoi.commands.__edit").watch)
          vim.notify('Chezmoi watching ' .. filename, vim.log.levels.INFO)
        end,
      })
    end,
  },

  {
    -- highlighting for chezmoi files template files
    "alker0/chezmoi.vim",
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = 1
      vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"
    end,
  },

  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  }

}
