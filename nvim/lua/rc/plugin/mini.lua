-- [nfnl] fnl/rc/plugin/mini.fnl
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
