-- [nfnl] Compiled from fnl/rc/plugin/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local gitsigns = require("gitsigns")
local icon = autoload("rc.icon")
local icontab = icon.tab
return gitsigns.setup({signs = {add = {text = icontab.plus}, change = {text = icontab.circle}, delete = {text = icontab.minus}, topdelete = {text = icontab["level-up"]}, changedelete = {text = icontab.dots}, untracked = {text = icontab.nbsp}}, signs_staged = {add = {text = icontab.plus}, change = {text = icontab.circle}, delete = {text = icontab.minus}, topdelete = {text = icontab["level-up"]}, changedelete = {text = icontab.dots}, untracked = {text = icontab.nbsp}}, signs_staged_enable = true, word_diff = true, watch_gitdir = {follow_files = true}, sign_priority = 6, update_debounce = 100, status_formatter = nil, linehl = false, numhl = false, current_line_blame = false})
