-- [nfnl] fnl/rc/plugin/dressing.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local dressing = require("dressing")
local icon = autoload("rc.icon")
local icontab = icon.tab
return dressing.setup({input = {default_prompt = icontab.rquot}})
