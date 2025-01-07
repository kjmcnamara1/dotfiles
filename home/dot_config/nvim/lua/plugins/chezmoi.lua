-- TODO: cleanup chezmoi.nvim
return {
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua", },
  keys = {
    { "<leader>fz", "<cmd>ChezmoiFzf<cr>", desc = "Fzf Chezmoi File" },
  },
  opts = { edit = { watch = true } },
  config = function()
    fzf_chezmoi = function()
      local cz_commands = require("chezmoi.commands")
      local cz_files = cz_commands.list({ args = { "--include=files" } })
      -- local cz_source = cz_commands.source_path()[1]

      local ChezmoiPreviewer = require("fzf-lua.previewer.builtin").buffer_or_file:extend()

      function ChezmoiPreviewer:new(o, opts, fzf_win)
        ChezmoiPreviewer.super.new(self, o, opts, fzf_win)
        setmetatable(self, ChezmoiPreviewer)
        return self
      end

      -- -- FIX: too slow
      -- -- try to use `chezmoi cat` and `Previewer:populate_preview_buf`
      -- function ChezmoiPreviewer:parse_entry(entry_str)
      --   local target_path = vim.fn.resolve(cz_commands.target_path()[1] .. "/" .. entry_str)
      --   -- local source_path = cz_commands.source_path({ args = { target_path } })[1]
      --   return {
      --     -- path = source_path,
      --     path = target_path,
      --     line = 1,
      --     col = 1,
      --   }
      -- end

      function ChezmoiPreviewer:populate_preview_buf(entry_str)
        local tmpbuf = self:get_tmp_buffer()
        vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, {})
      end

      require("fzf-lua").fzf_exec(cz_files, {
        -- previewer = ChezmoiPreviewer,
        actions = {
          ["default"] = function(selected, opts)
            cz_commands.edit({
              targets = { "~/" .. selected[1] },
              args = { "--watch" }
            })
          end
        }
      })
    end
    vim.api.nvim_command("command! ChezmoiFzf lua fzf_chezmoi()")
  end,
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
