-- [nfnl] Compiled from fnl/rc/plugin/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local dap = require("dap")
local dapui = require("dapui")
local color = autoload("rc.color")
local icon = autoload("rc.icon")
local colors = color.colors
local icontab = icon.tab
local adapters_dir = (vim.fn.stdpath("data") .. "/dap")
if not (vim.fn.isdirectory(adapters_dir) == 1) then
  vim.fn.mkdir(adapters_dir, "p")
else
end
if (vim.fn.executable("dlv") == 1) then
  local dlv_path = vim.fn.exepath("dlv")
  local vscode_go_path = (adapters_dir .. "/vscode-go")
  local debug_adapter_path = (vscode_go_path .. "/dist/debugAdapter.js")
  local function dap_sync_go_adapter()
    if vim.fn.empty(vim.fn.glob(vscode_go_path)) then
      vim.cmd(string.format(("!git clone --depth 1 " .. "http://github.com/golang/vscode-go %s; " .. "cd %s; " .. "npm install; " .. "npm run compile"), vscode_go_path, vscode_go_path))
      return vim.notify("finished to install Go adapter.", vim.lsp.log_levels.INFO, {annote = "dap-sync-go-adapter"})
    else
      vim.cmd(string.format(("!cd %s; " .. "git pull origin master; " .. "npm install; " .. "npm run compile"), vscode_go_path))
      return vim.notify("finished to update Go adapter.", vim.lsp.log_levels.WARN, {annote = "dap-sync-go-adapter"})
    end
  end
  vim.api.nvim_create_user_command("DapSyncGoAdapter", dap_sync_go_adapter, {})
  dap.adapters.go = {name = "dlv", type = "executable", command = "node", args = {debug_adapter_path}}
  dap.configurations.go = {{type = "go", name = "Launch file", request = "launch", showLog = true, program = "${file}", dlvToolPath = dlv_path}, {type = "go", name = "Launch test file", request = "launch", mode = "test", showLog = true, program = "${file}", args = {"-test.v"}, dlvToolPath = dlv_path}}
else
end
dap.adapters.rego = {name = "regal-debug", type = "executable", command = "regal", args = {"debug"}}
dap.configurations.rego = {{type = "rego", name = "Debug Workspace", request = "launch", command = "eval", query = "data", dataPaths = {"${file}"}, enablePrint = true, logLevel = "info"}, {type = "rego", name = "Launch Rego Workspace", request = "launch", command = "eval", query = "data", enablePrint = true, logLevel = "info", inputPath = "${workspaceFolder}/input.json", dataPaths = {"${file}"}}}
dapui.setup({icons = {expanded = icontab["fold-open"], collapsed = icontab["fold-closed"]}})
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
vim.api.nvim_create_user_command("DapUIOpen", "lua require('dapui').open()", {})
vim.api.nvim_create_user_command("DapUIClose", "lua require('dapui').close()", {})
vim.api.nvim_create_user_command("DapUIToggle", "lua require('dapui').toggle()", {})
vim.keymap.set("n", "<F5>", ":<C-u>DapContinue<CR>", {silent = true})
vim.keymap.set("n", "<F9>", ":<C-u>DapToggleBreakpoint<CR>", {silent = true})
vim.keymap.set("n", "<F10>", ":<C-u>DapStepOver<CR>", {silent = true})
vim.keymap.set("n", "<F11>", ":<C-u>DapStepInto<CR>", {silent = true})
return vim.keymap.set("n", "<F12>", ":<C-u>DapStepOut<CR>", {silent = true})
