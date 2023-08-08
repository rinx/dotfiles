-- [nfnl] Compiled from fnl/rc/plugin/toggleterm.fnl by https://github.com/Olical/nfnl, do not edit.
local toggleterm = require("toggleterm")
toggleterm.setup({})
return vim.keymap.set("n", "<leader>w", ":<C-u>ToggleTerm<CR>", {silent = true})
