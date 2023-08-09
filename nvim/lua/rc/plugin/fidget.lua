-- [nfnl] Compiled from fnl/rc/plugin/fidget.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local fidget = require("fidget")
local icon = autoload("rc.icon")
local icontab = icon.tab
return fidget.setup({text = {spinner = icon.spinners, done = icontab.check}})
