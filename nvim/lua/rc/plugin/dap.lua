-- [nfnl] Compiled from fnl/rc/plugin/dap.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local dap = require("dap")
local dap_ext_vscode = require("dap.ext.vscode")
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
do
  local adapter_path = (adapters_dir .. "/codelldb")
  local codelldb_path = (adapter_path .. "/extension/adapter/codelldb")
  local codelldb_url
  if (vim.fn.has("unix") == 1) then
    codelldb_url = "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-linux.vsix"
  else
    codelldb_url = "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-darwin.vsix"
  end
  local function dap_sync_lldb_adapter()
    if vim.fn.empty(vim.fn.glob(adapter_path)) then
      vim.cmd(string.format(("!curl -L %s --output /tmp/codelldb.zip; " .. "unzip /tmp/codelldb.zip -d %s; " .. "rm -rf /tmp/codelldb.zip"), codelldb_url, adapter_path))
      return vim.notify("finished to install codelldb.", vim.lsp.log_levels.INFO, {annote = "dap-sync-lldb-adapter"})
    else
      return vim.notify("codelldb already installed.", vim.lsp.log_levels.WARN, {annote = "dap-sync-lldb-adapter"})
    end
  end
  vim.api.nvim_create_user_command("DapSyncLLDBAdapter", dap_sync_lldb_adapter, {})
  local function _7_(callback, config)
    local port = math.random(30000, 40000)
    local handle, pid_or_err = nil, nil
    local function _8_(code)
      handle:close()
      return vim.notify(("codelldb exited with code: " .. code), vim.lsp.log_levels.ERROR, {title = "dap-adapters-rust"})
    end
    handle, pid_or_err = vim.loop.spawn(codelldb_path, {args = {"--port", string.format("%d", port)}, detached = true}, _8_)
    local function _9_()
      return callback({type = "server", host = "127.0.0.1", port = port})
    end
    return vim.defer_fn(_9_, 500)
  end
  dap.adapters.rust = _7_
  local cwd = vim.fn.getcwd()
  local pkg_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  dap.configurations.rust = {{type = "rust", name = "Debug executable", request = "launch", args = {}, cwd = cwd, program = ("target/debug/" .. pkg_name)}}
end
do
  local adapter_path = (adapters_dir .. "/kotlin")
  local bin_path = (adapter_path .. "/adapter/build/install/adapter/bin/kotlin-debug-adapter")
  local function dap_sync_kotlin_adapter()
    if vim.fn.empty(vim.fn.glob(adapter_path)) then
      vim.cmd(string.format(("!git clone --depth 1 " .. "https://github.com/fwcd/kotlin-debug-adapter %s; " .. "cd %s; " .. "./gradlew :adapter:installDist"), adapter_path, adapter_path))
      return vim.notify("finished to install kotlin-debug-adapter", vim.lsp.log_levels.INFO, {annote = "dap-sync-kotlin-adapter"})
    else
      return vim.notify("kotlin-debug-adapter already installed.", vim.lsp.log_levels.WARN, {annote = "dap-sync-kotlin-adapter"})
    end
  end
  vim.api.nvim_create_user_command("DapSyncKotlinAdapter", dap_sync_kotlin_adapter, {})
  dap.adapters.kotlin = {name = "kotlin-debug-adapter", type = "executable", command = bin_path}
end
local function load_launch_js()
  local cwd = vim.fn.getcwd()
  local path = (cwd .. "/.vscode/launch.json")
  if vim.loop.fs_stat(path) then
    vim.notify("loading .vscode/launch.json...", vim.lsp.log_levels.INFO, {annote = "dap-load-launch-js"})
    pcall(dap_ext_vscode.load_launchjs)
    return vim.notify("finished to load .vscode/launch.json.", vim.lsp.log_levels.INFO, {annote = "dap-load-launch-js"})
  else
    return nil
  end
end
vim.api.nvim_create_user_command("DapLoadLaunchJSON", load_launch_js, {})
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
