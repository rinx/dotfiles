-- [nfnl] Compiled from fnl/rc/plugin/leap.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.del("n", "ZQ")
vim.keymap.del("n", "ZZ")
do
  vim.keymap.set("n", "z", "<Plug>(leap-forward)", {})
  vim.keymap.set("x", "z", "<Plug>(leap-forward)", {})
  vim.keymap.set("o", "z", "<Plug>(leap-forward)", {})
end
vim.keymap.set("n", "Z", "<Plug>(leap-backward)", {})
vim.keymap.set("x", "Z", "<Plug>(leap-backward)", {})
return vim.keymap.set("o", "Z", "<Plug>(leap-backward)", {})
