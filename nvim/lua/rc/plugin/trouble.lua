-- [nfnl] Compiled from fnl/rc/plugin/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local trouble = require("trouble")
local icon = autoload("rc.icon")
local icontab = icon.tab
trouble.setup({auto_close = true, modes = {diagnostics = {auto_open = true}}, signs = {error = icontab.bug, warning = icontab["exclam-circle"], hint = icontab.leaf, information = icontab["info-circle"], other = icontab["comment-alt"]}, action_keys = {switch_severity = "S"}})
vim.keymap.set("n", "<leader>xx", ":<C-u>Trouble diagnostics toggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>xX", ":<C-u>Trouble diagnostics toggle filter.buf=0<CR>", {silent = true})
vim.keymap.set("n", "<leader>xd", ":<C-u>Trouble lsp toggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>xq", ":<C-u>Trouble qflist toggle<CR>", {silent = true})
return vim.keymap.set("n", "<leader>xl", ":<C-u>Trouble loclist toggle<CR>", {silent = true})
