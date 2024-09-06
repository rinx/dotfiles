-- [nfnl] Compiled from fnl/rc/plugin/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local trouble = require("trouble")
trouble.setup({auto_close = true})
do
  local group_5_auto = vim.api.nvim_create_augroup("trouble-qf-open", {clear = true})
  local function _2_()
    return vim.cmd("Trouble qflist open")
  end
  vim.api.nvim_create_autocmd({"QuickFixCmdPost"}, {callback = _2_, group = group_5_auto})
end
vim.keymap.set("n", "<leader>xx", ":<C-u>Trouble diagnostics toggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>xX", ":<C-u>Trouble diagnostics toggle filter.buf=0<CR>", {silent = true})
vim.keymap.set("n", "<leader>xd", ":<C-u>Trouble lsp toggle focus=false win.position=right<CR>", {silent = true})
vim.keymap.set("n", "<leader>xs", ":<C-u>Trouble symbols toggle focus=false<CR>", {silent = true})
vim.keymap.set("n", "<leader>xq", ":<C-u>Trouble qflist toggle<CR>", {silent = true})
return vim.keymap.set("n", "<leader>xl", ":<C-u>Trouble loclist toggle<CR>", {silent = true})
