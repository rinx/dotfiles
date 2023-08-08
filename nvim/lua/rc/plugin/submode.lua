-- [nfnl] Compiled from fnl/rc/plugin/submode.fnl by https://github.com/Olical/nfnl, do not edit.
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '>', '<C-w>>')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '<', '<C-w><')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '+', '<C-w>+')")
return vim.cmd("silent call submode#map('bufmove', 'n', '', '-', '<C-w>-')")
