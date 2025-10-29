-- [nfnl] fnl/rc/plugin/dap.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local dap = require("dap")
local view = require("dap-view")
local color = autoload("rc.color")
local icon = autoload("rc.icon")
local colors = color.colors
local icontab = icon.tab
view.setup({})
dap.adapters.vcl = {name = "falco", type = "executable", command = "falco", args = {"dap"}}
dap.configurations.vcl = {{type = "vcl", name = "Debug VCL by Falco", request = "launch", mainVCL = "${file}", includePaths = {"${workspaceFolder}"}}}
dap.listeners.before.attach.dap_view_config = view.open
dap.listeners.before.launch.dap_view_config = view.open
dap.listeners.before.event_terminated.dap_view_config = view.close
dap.listeners.before.event_exited.dap_view_config = view.close
vim.cmd(("highlight " .. (("DapBreakpoint" .. " " .. ("ctermfg" .. "=" .. "red")) .. " " .. ("guifg" .. "=" .. colors.error))))
vim.cmd(("highlight " .. (("DapLogPoint" .. " " .. ("ctermfg" .. "=" .. "yellow")) .. " " .. ("guifg" .. "=" .. colors.warn))))
vim.cmd(("highlight " .. (("DapStopped" .. " " .. ("ctermfg" .. "=" .. "blue")) .. " " .. ("guifg" .. "=" .. colors.hint))))
vim.fn.sign_define("DapBreakpoint", {text = icontab.circle, texthl = "DapBreakpoint"})
vim.fn.sign_define("DapLogPoint", {text = icontab.comment, texthl = "DapLogPoint"})
vim.fn.sign_define("DapStopped", {text = icontab["arrow-r"], texthl = "DapStopped"})
vim.fn.sign_define("DapBreakpointRejected", {text = icontab.times, texthl = "DapBreakpoint"})
vim.api.nvim_create_user_command("DapToggleBreakpoint", "lua require('dap').toggle_breakpoint()", {})
vim.api.nvim_create_user_command("DapListBreakpoints", "lua require('dap').list_breakpoints()", {})
vim.api.nvim_create_user_command("DapContinue", "lua require('dap').continue()", {})
vim.api.nvim_create_user_command("DapStepOver", "lua require('dap').step_over()", {})
vim.api.nvim_create_user_command("DapStepInto", "lua require('dap').step_into()", {})
vim.api.nvim_create_user_command("DapStepOut", "lua require('dap').step_out()", {})
vim.keymap.set("n", "<F5>", ":<C-u>DapContinue<CR>", {silent = true})
vim.keymap.set("n", "<F9>", ":<C-u>DapToggleBreakpoint<CR>", {silent = true})
vim.keymap.set("n", "<F10>", ":<C-u>DapStepOver<CR>", {silent = true})
vim.keymap.set("n", "<F11>", ":<C-u>DapStepInto<CR>", {silent = true})
return vim.keymap.set("n", "<F12>", ":<C-u>DapStepOut<CR>", {silent = true})
