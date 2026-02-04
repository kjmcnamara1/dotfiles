return {}

-- return {

--   {
--     "kevinhwang91/nvim-ufo",
--     enabled = true,
--     dependencies = {
--       "neovim/nvim-lspconfig",
--       "kevinhwang91/promise-async",
--     },
--     lazy = false,
--     cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold", },
--     keys = {
--       { "zR", function() require("ufo").openAllFolds() end,         desc = "Open all folds" },
--       { "zM", function() require("ufo").closeAllFolds() end,        desc = "Close all folds" },
--       { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds" },
--       { "zm", function() require("ufo").closeFoldsWith() end,       desc = "Close folds" },
--       {
--         "<leader>k",
--         function()
--           local winid = require("ufo").peekFoldedLinesUnderCursor()
--           if not winid then
--             vim.lsp.buf.hover()
--           end
--         end,
--         desc = "LSP: Hover"
--       }
--     },
--     -- opts = {
--     --   provider_selector = function(bufnr, filetype, buftype)
--     --     return { 'lsp', 'treesitter' }
--     --   end
--     -- },
--     config = function(_, opts)
--       vim.o.foldcolumn = "0" -- '0' is not bad
--       vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
--       vim.o.foldlevelstart = 99
--       vim.o.foldenable = true

--       vim.lsp.config("*", {
--         capabilities = {
--           textDocument = {
--             foldingRange = {
--               dynamicRegistration = false,
--               lineFoldingOnly = true,
--             }
--           }
--         }
--       })

--       require("ufo").setup(opts)
--     end
--   },

-- }
