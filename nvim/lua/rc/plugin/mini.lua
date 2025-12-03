-- [nfnl] fnl/rc/plugin/mini.fnl
do
  local ai = require("mini.ai")
  local extra = require("mini.extra")
  local gas = extra.gen_ai_spec
  ai.setup({custom_textobjects = {B = gas.buffer(), D = gas.diagnostic(), I = gas.indent(), L = gas.line(), N = gas.number()}})
end
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
