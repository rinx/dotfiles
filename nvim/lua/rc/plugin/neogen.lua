-- [nfnl] Compiled from fnl/rc/plugin/neogen.fnl by https://github.com/Olical/nfnl, do not edit.
local neogen = require("neogen")
neogen.setup({enabled = true})
return vim.keymap.set("n", "<Leader>n", ":<C-u>lua require('neogen').generate()<CR>", {silent = true})
