-- [nfnl] Compiled from fnl/rc/plugin/lightbulb.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lightbulb = require("nvim-lightbulb")
local icon = autoload("rc.icon")
local icontab = icon.tab
return lightbulb.setup({autocmd = {enabled = true}, sign = {enabled = true, text = icontab.lightbulb, hl = "DiagnosticSignLightBulb"}})
