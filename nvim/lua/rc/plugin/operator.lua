-- [nfnl] Compiled from fnl/rc/plugin/operator.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("", "X", "<Plug>(operator-replace)", {})
vim.keymap.set("", "Sa", "<Plug>(operator-surround-append)", {})
vim.keymap.set("", "Sd", "<Plug>(operator-surround-delete)", {})
return vim.keymap.set("", "Sr", "<Plug>(operator-surround-replace)", {})
