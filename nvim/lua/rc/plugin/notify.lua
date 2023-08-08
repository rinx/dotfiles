-- [nfnl] Compiled from fnl/rc/plugin/notify.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local notify = require("notify")
local icon = autoload("rc.icon")
local icontab = icon.tab
local function setup_notify()
  if not core["empty?"](vim.api.nvim_list_uis()) then
    notify.setup({stages = "fade_in_slide_out", timeout = 5000, background_colour = "#000000", icons = {ERROR = icontab.ban, WARN = icontab["exclam-tri"], INFO = icontab["info-circle"], DEBUG = icontab.bug, TRACE = icontab.bug}})
    vim.notify = notify
    return nil
  else
    return nil
  end
end
local group_5_auto = vim.api.nvim_create_augroup("init-notify", {clear = true})
return vim.api.nvim_create_autocmd({"UIEnter"}, {callback = setup_notify, group = group_5_auto, pattern = "*"})
