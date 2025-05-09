-- [nfnl] fnl/rc/plugin/submode.fnl
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')")
vim.cmd("silent call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '>', '<C-w>>')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '<', '<C-w><')")
vim.cmd("silent call submode#map('bufmove', 'n', '', '+', '<C-w>+')")
return vim.cmd("silent call submode#map('bufmove', 'n', '', '-', '<C-w>-')")
