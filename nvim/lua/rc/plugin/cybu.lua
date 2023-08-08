-- [nfnl] Compiled from fnl/rc/plugin/cybu.fnl by https://github.com/Olical/nfnl, do not edit.
local cybu = require("cybu")
cybu.setup({position = {anchor = "bottomright"}, style = {path = "tail", border = "rounded"}, display_time = 1000})
vim.keymap.set("n", "gt", ":<C-u>lua require('cybu').cycle('next')<CR>", {silent = true})
return vim.keymap.set("n", "gT", ":<C-u>lua require('cybu').cycle('prev')<CR>", {silent = true})
