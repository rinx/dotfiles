-- [nfnl] Compiled from fnl/rc/plugin/fidget.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local fidget = require("fidget")
local spinner = require("fidget.spinner")
local icon = autoload("rc.icon")
local icontab = icon.tab
return fidget.setup({progress = {display = {progress_icon = spinner.animate(icon.spinners), done_icon = icontab.check}}})
