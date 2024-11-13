local vscode = require("vscode-neovim")

vim.notify = vscode.notify

vim.opt.scrolloff = 999
-- vim.keymap.set({ "n", "x" }, "<c-d>", "15j", { remap = true })
-- vim.keymap.set({ "n", "x" }, "<c-u>", "15k", { remap = true })
vim.keymap.set({ "n", "x" }, "<c-d>", "<c-d>zz", { remap = true })
vim.keymap.set({ "n", "x" }, "<c-u>", "<c-u>zz", { remap = true })
vim.keymap.set("", "j", "gj", { remap = true })
vim.keymap.set("", "k", "gk", { remap = true })

-- LSP
vim.keymap.set({ "n", "x" }, "gs", function() vscode.action("workbench.action.gotoSymbol") end)
vim.keymap.set({ "n", "x" }, "<leader>o", function() vscode.action("workbench.action.gotoSymbol") end)
vim.keymap.set({ "n", "x" }, "gS", function() vscode.action("workbench.action.showAllSymbols") end)
vim.keymap.set({ "n", "x" }, "<leader>O", function() vscode.action("workbench.action.showAllSymbols") end)
vim.keymap.set({ "n", "x" }, "gr", function() vscode.action("editor.action.referenceSearch.trigger") end)
vim.keymap.set({ "n", "x" }, "<leader>cr", function() vscode.action("editor.action.rename") end)

-- Git
vim.keymap.set("n", "]h", function() vscode.action("workbench.action.editor.nextChange") end)         -- next hunk
vim.keymap.set("n", "[h", function() vscode.action("workbench.action.editor.previousChange") end)     -- prev hunk
vim.keymap.set("n", "<leader>hp", function() vscode.action("editor.action.dirtydiff.next") end)       -- preview hunk

vim.keymap.set({ "n", "v" }, "<leader>hs", function() vscode.action("git.stageSelectedRanges") end)   -- stage hunk
vim.keymap.set({ "n", "v" }, "<leader>hu", function() vscode.action("git.unstageSelectedRanges") end) -- unstage hunk
vim.keymap.set({ "n", "v" }, "<leader>hr", function() vscode.action("git.revertSelectedRanges") end)  -- revert hunk

vim.keymap.set("n", "<leader>gS", function() vscode.action("git.stage") end)                          -- stage buffer
vim.keymap.set("n", "<leader>gU", function() vscode.action("git.unstage") end)                        -- unstage buffer
vim.keymap.set("n", "<leader>gR", function() vscode.action("git.clean") end)                          -- revert buffer

vim.keymap.set("n", "<leader>gb", function() vscode.action("gitlens.toggleLineBlame") end)            -- line blame
vim.keymap.set("n", "<leader>gd", function() vscode.action("git.openChange") end)                     -- diff file
vim.keymap.set("n", "<leader>gf", function() vscode.action("git.fetch") end)                          -- git fetch
vim.keymap.set("n", "<leader>gc", function() vscode.action("git.commit") end)                         -- git commit
vim.keymap.set("n", "<leader>gp", function() vscode.action("git.pull") end)                           -- git pull
vim.keymap.set("n", "<leader>gP", function() vscode.action("git.push") end)                           -- git push

-- Diagnostics
vim.keymap.set("n", "]d", function() vscode.action("editor.action.marker.next") end)
vim.keymap.set("n", "[d", function() vscode.action("editor.action.marker.prev") end)
vim.keymap.set("n", "<leader>dd", function() vscode.action("workbench.actions.view.problems") end)

-- TODO
vim.keymap.set("n", "]t", function() vscode.action("todo-tree.goToNext") end)
vim.keymap.set("n", "[t", function() vscode.action("todo-tree.goToPrevious") end)

-- User Interface
vim.keymap.set("n", "<leader>ui", function() vscode.action("editor.action.inspectTMScopes") end)
vim.keymap.set("n", "<leader>uC", function() vscode.action("workbench.action.selectTheme") end)

-- File Type / Lanugage Mode
vim.keymap.set("n", "<leader>;", function() vscode.action("workbench.action.editor.changeLanguageMode") end)

-- Files
vim.keymap.set("n", "-", function() vscode.action("workbench.view.explorer") end)
vim.keymap.set("n", "<leader>.", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>r", function() vscode.action("workbench.action.openRecent") end)
vim.keymap.set("n", "<leader>n", function() vscode.action("workbench.action.files.newUntitledFile") end)

-- Keymaps
vim.keymap.set("n", "<leader>ks", function() vscode.action("workbench.action.openGlobalKeybindings") end)

-- Zen mode
vim.keymap.set("n", "<leader>z", function() vscode.action("workbench.action.toggleZenMode") end)

-- Multi Cursor
vim.keymap.set("n", "<C-n>", "mciw*<Cmd>nohl<CR>", { remap = true })

-- Folds
vim.keymap.set("n", "]z", function() vscode.action("editor.gotoNextFold") end)
vim.keymap.set("n", "[z", function() vscode.action("editor.gotoPreviousFold") end)
vim.keymap.set("x", "zf", function() vscode.action("editor.createFoldingRangeFromSelection") end)
vim.keymap.set("n", "z.", function() vscode.action("editor.removeManualFoldingRanges") end)
vim.keymap.set("n", "za", function() vscode.action("editor.toggleFold") end)
vim.keymap.set("n", "zc", function() vscode.action("editor.fold") end)
vim.keymap.set("n", "zC", function() vscode.action("editor.foldRecursively") end)
vim.keymap.set("n", "zo", function() vscode.action("editor.unfold") end)
vim.keymap.set("n", "zO", function() vscode.action("editor.unfoldRecursively") end)
vim.keymap.set("n", "zM", function() vscode.action("editor.foldAll") end)
vim.keymap.set("n", "zR", function() vscode.action("editor.unfoldAll") end)
vim.keymap.set("n", "z1", function() vscode.action("editor.foldLevel1") end)
vim.keymap.set("n", "z2", function() vscode.action("editor.foldLevel2") end)
vim.keymap.set("n", "z3", function() vscode.action("editor.foldLevel3") end)
vim.keymap.set("n", "z4", function() vscode.action("editor.foldLevel4") end)
vim.keymap.set("n", "z5", function() vscode.action("editor.foldLevel5") end)
vim.keymap.set("n", "z6", function() vscode.action("editor.foldLevel6") end)
vim.keymap.set("n", "z7", function() vscode.action("editor.foldLevel7") end)
