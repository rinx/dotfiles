-- [nfnl] fnl/rc/plugin/leap.fnl
vim.keymap.del("n", "ZQ")
vim.keymap.del("n", "ZZ")
do
  vim.keymap.set("n", "z", "<Plug>(leap-forward)", {desc = "Leap: forward"})
  vim.keymap.set("x", "z", "<Plug>(leap-forward)", {desc = "Leap: forward"})
  vim.keymap.set("o", "z", "<Plug>(leap-forward)", {desc = "Leap: forward"})
end
vim.keymap.set("n", "Z", "<Plug>(leap-backward)", {desc = "Leap: backward"})
vim.keymap.set("x", "Z", "<Plug>(leap-backward)", {desc = "Leap: backward"})
return vim.keymap.set("o", "Z", "<Plug>(leap-backward)", {desc = "Leap: backward"})
