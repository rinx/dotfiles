-- [nfnl] Compiled from fnl/rc/plugin/fidget.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local fidget = require("fidget")
local spinner = require("fidget.spinner")
local icon = autoload("rc.icon")
local icontab = icon.tab
fidget.setup({progress = {display = {progress_icon = spinner.animate(icon.spinners), done_icon = icontab.check}}})
local function setup_notify()
  if not core["empty?"](vim.api.nvim_list_uis()) then
    vim.notify = fidget.notify
    return nil
  else
    return nil
  end
end
local group_5_auto = vim.api.nvim_create_augroup("init-notify", {clear = true})
return vim.api.nvim_create_autocmd({"UIEnter"}, {callback = setup_notify, group = group_5_auto, pattern = "*"})
