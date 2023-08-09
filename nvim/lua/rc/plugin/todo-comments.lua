-- [nfnl] Compiled from fnl/rc/plugin/todo-comments.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local tdc = require("todo-comments")
local color = autoload("rc.color")
local icon = autoload("rc.icon")
local colors = color.colors
local icontab = icon.tab
return tdc.setup({signs = true, keywords = {FIX = {icon = icontab.bug, color = "error", alt = {"FIXME", "BUG", "FIXIT", "FIX", "ISSUE"}}, TODO = {icon = icontab.check, color = "info"}, HACK = {icon = icontab.fire, color = "warning"}, WARN = {icon = icontab["excram-tri"], color = "warning"}, PERF = {icon = icontab.watch, color = "default", alt = {"OPTIM", "PERFORMANCE", "OPTIMIZE"}}, NOTE = {icon = icontab["comment-alt"], color = "hint", alt = {"INFO"}}}, colors = {error = {"DiagnosticSignError"}, warning = {"DiagnosticSignWarn"}, info = {"DiagnosticSignInfo"}, hint = {"DiagnosticSignHint"}, default = {colors.purple}}})
