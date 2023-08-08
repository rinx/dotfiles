-- [nfnl] Compiled from fnl/rc/plugin/devicons.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local devicon = require("nvim-web-devicons")
local icon = autoload("rc.icon")
local icontab = icon.tab
return devicon.setup({override = {fnl = {icon = icontab.lua, color = "#c2d94c", name = "Fennel"}, hy = {icon = icontab.python, color = "#519aba", name = "Hy"}, Makefile = {icon = icontab["large-m"], color = "#6d8086", name = "Makefile"}, norg = {icon = icontab["sticky-note"], color = "#36a3d9", name = "norg"}}})
