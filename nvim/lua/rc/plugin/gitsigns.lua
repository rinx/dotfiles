-- [nfnl] Compiled from fnl/rc/plugin/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local gitsigns = require("gitsigns")
local icon = autoload("rc.icon")
local icontab = icon.tab
return gitsigns.setup({signs = {add = {hl = "GitSignsAdd", text = icontab.plus, numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"}, change = {hl = "GitSignsChange", text = icontab.circle, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}, delete = {hl = "GitSignsDelete", text = icontab.minus, numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"}, topdelete = {hl = "GitSignsDelete", text = icontab["level-up"], numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"}, changedelete = {hl = "GitSignsChange", text = icontab.dots, numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}}, watch_gitdir = {interval = 1000}, sign_priority = 6, update_debounce = 100, status_formatter = nil, diff_opts = {internal = true}, numhl = false, current_line_blame = false, linehl = false})
