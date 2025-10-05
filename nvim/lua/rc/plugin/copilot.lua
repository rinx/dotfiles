-- [nfnl] fnl/rc/plugin/copilot.fnl
local copilot = require("copilot")
local command = require("copilot.command")
local client = require("copilot.client")
copilot.setup({suggestion = {enabled = false}, panel = {enabled = false}, server_opts_overrides = {cmd = {"copilot-language-server", "--stdio"}, trace = "verbose", settings = {advanced = {listCount = 10, inlineSuggestCount = 3}}}})
command.disable()
local toggle
local function _1_()
  return not client.is_disabled()
end
local function _2_(state)
  if state then
    return command.enable()
  else
    return command.disable()
  end
end
toggle = Snacks.toggle.new({id = "copilot", name = "Copilot", get = _1_, set = _2_})
return toggle:map("<leader>c")
