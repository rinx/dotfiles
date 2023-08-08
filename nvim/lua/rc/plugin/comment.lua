-- [nfnl] Compiled from fnl/rc/plugin/comment.fnl by https://github.com/Olical/nfnl, do not edit.
local cm = require("Comment")
local ts_commentstring = require("ts_context_commentstring.internal")
local function _1_(ctx)
  return ts_commentstring.calculate_commentstring()
end
return cm.setup({pre_hook = _1_})
