-- [nfnl] Compiled from fnl/rc/plugin/waitevent.fnl by https://github.com/Olical/nfnl, do not edit.
do
  local waitevent = require("waitevent")
  local function _1_(ctx, path)
    vim.cmd.vsplit(path)
    ctx.lcd()
    vim.bo.bufhidden = "wipe"
    return nil
  end
  vim.env.GIT_EDITOR = waitevent.editor({open = _1_})
end
do
  local waitevent = require("waitevent")
  vim.env.EDITOR = waitevent.editor({done_events = {}, cancel_events = {}})
end
return nil
