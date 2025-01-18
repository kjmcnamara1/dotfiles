return {
  "xvzc/chezmoi.nvim",
  enabled = not vim.g.vscode,
  dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua", },
  opts = { edit = { watch = true } },
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { os.getenv("HOME") .. "/.local/share/chezmoi/*" },
      group = vim.api.nvim_create_augroup("chezmoi", { clear = true }),
      callback = function(ev)
        vim.schedule(
          function()
            require("chezmoi.commands.__edit").watch(ev.buf)
          end
        )
      end,
    })
  end,
}
