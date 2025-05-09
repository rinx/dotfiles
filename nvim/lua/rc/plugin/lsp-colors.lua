-- [nfnl] fnl/rc/plugin/lsp-colors.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lsp_colors = require("lsp-colors")
local color = autoload("rc.color")
local colors = color.colors
return lsp_colors.setup({Error = colors.error, Warning = colors.warn, Information = colors.info, Hint = colors.hint})
