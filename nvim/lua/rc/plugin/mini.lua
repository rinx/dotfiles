-- [nfnl] Compiled from fnl/rc/plugin/mini.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local align = require("mini.align")
  align.setup()
end
do
  local operators = require("mini.operators")
  operators.setup({replace = {prefix = "X", reindent_linewise = true}})
end
do
  local pairs = require("mini.pairs")
  pairs.setup()
end
do
  local surround = require("mini.surround")
  surround.setup({mappings = {highlight = ""}})
end
local trailspace = require("mini.trailspace")
return trailspace.setup()
