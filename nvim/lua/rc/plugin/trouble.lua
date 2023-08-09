-- [nfnl] Compiled from fnl/rc/plugin/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local trouble = require("trouble")
local icon = autoload("rc.icon")
local icontab = icon.tab
trouble.setup({auto_open = true, auto_close = true, signs = {error = icontab.bug, warning = icontab["exclam-circle"], hint = icontab.leaf, information = icontab["info-circle"], other = icontab["comment-alt"]}})
vim.keymap.set("n", "<leader>xx", ":<C-u>TroubleToggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>xw", ":<C-u>TroubleToggle lsp_workspace_diagnostics<CR>", {silent = true})
vim.keymap.set("n", "<leader>xd", ":<C-u>TroubleToggle lsp_document_diagnostics<CR>", {silent = true})
vim.keymap.set("n", "<leader>xq", ":<C-u>TroubleToggle quickfix<CR>", {silent = true})
vim.keymap.set("n", "<leader>xl", ":<C-u>TroubleToggle loclist<CR>", {silent = true})
return vim.keymap.set("n", "gR", ":<C-u>TroubleToggle lsp_references<CR>", {silent = true})
