-- ================================================================================
-- * Sudo Write
-- ================================================================================

return {
  "lambdalisue/vim-suda",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    {
      "<c-s>",
      function()
        local buf = vim.api.nvim_win_get_buf(0)
        if vim.bo[buf].readonly then
          vim.cmd.SudaWrite()
        else
          vim.cmd.write()
        end
      end,
      desc = "Save file",
      mode = { "i", "x", "n", "s" },
    },
    -- { "<c-s-s>", "<cmd>wa<cr>", desc = "Save all files" },
    { "<c-s-s>", "<cmd>noautocmd w<cr>", desc = "Save without autoformatting" },
  },
}
