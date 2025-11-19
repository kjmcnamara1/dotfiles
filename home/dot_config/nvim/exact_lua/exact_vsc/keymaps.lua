local vscode = require("vscode-neovim")

vim.notify = vscode.notify

vim.keymap.set("n", "<leader><space>", function() vscode.action("workbench.action.quickOpen") end)
vim.keymap.set("n", "<leader>fr", function() vscode.action("workbench.action.openRecent") end)
vim.keymap.set("n", "<leader>e", function() vscode.action("workbench.view.explorer") end)
vim.keymap.set("n", "<leader>bn", function() vscode.action("workbench.action.files.newUntitledFile") end)

vim.keymap.set("n", "<leader>ft", function() vscode.action("workbench.action.editor.changeLanguageMode") end)

vim.keymap.set("n", "<leader>sk", function() vscode.action("workbench.action.openGlobalKeybindings") end)

vim.keymap.set({ "n", "x" }, "grr", function() vscode.action("editor.action.referenceSearch.trigger") end)
vim.keymap.set({ "n", "x" }, "grn", function() vscode.action("editor.action.rename") end)
vim.keymap.set({ "n", "x" }, "g.", function() vscode.action("editor.action.quickFix") end)
vim.keymap.set({ "n", "x" }, "go", function() vscode.action("workbench.action.gotoSymbol") end)
vim.keymap.set({ "n", "x" }, "gO", function() vscode.action("workbench.action.showAllSymbols") end)
vim.keymap.set({ "n", "x" }, "<leader>k", function() vscode.action("editor.action.showHover") end)

vim.keymap.set("n", "]d", function() vscode.action("editor.action.marker.next") end)
vim.keymap.set("n", "[d", function() vscode.action("editor.action.marker.prev") end)
vim.keymap.set("n", "<leader>xx", function() vscode.action("workbench.actions.view.problems") end)

vim.keymap.set("n", "]h", function() vscode.action("workbench.action.editor.nextChange") end)     -- next hunk
vim.keymap.set("n", "[h", function() vscode.action("workbench.action.editor.previousChange") end) -- prev hunk

vim.keymap.set("n", "<leader>ui", function() vscode.actioan("editor.action.inspectTMScopes") end)
vim.keymap.set("n", "<leader>uC", function() vscode.action("workbench.action.selectTheme") end)
vim.keymap.set("n", "<leader>uz", function() vscode.action("workbench.action.toggleZenMode") end)

vim.keymap.set("n", "za", function() vscode.action("editor.toggleFold") end)
vim.keymap.set("n", "zc", function() vscode.action("editor.fold") end)
vim.keymap.set("n", "zC", function() vscode.action("editor.foldRecursively") end)
vim.keymap.set("n", "zo", function() vscode.action("editor.unfold") end)
vim.keymap.set("n", "zO", function() vscode.action("editor.unfoldRecursively") end)
vim.keymap.set("n", "zM", function() vscode.action("editor.foldAll") end)
vim.keymap.set("n", "zR", function() vscode.action("editor.unfoldAll") end)

return {}
