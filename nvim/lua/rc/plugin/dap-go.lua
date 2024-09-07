-- [nfnl] Compiled from fnl/rc/plugin/dap-go.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local dap_go = require("dap-go")
dap_go.setup({})
vim.api.nvim_create_user_command("DapGoTest", "lua require('dap-go').debug_test()", {})
vim.api.nvim_create_user_command("DapGoLastTest", "lua require('dap-go').debug_last_test()", {})
vim.keymap.set("n", "<F6>", ":<C-u>DapGoTest<CR>", {silent = true})
return vim.keymap.set("n", "<F7>", ":<C-u>DapGoLastTest<CR>", {silent = true})
