-- [nfnl] Compiled from fnl/rc/plugin/textobj.fnl by https://github.com/Olical/nfnl, do not edit.
vim.g.textobj_between_no_default_key_mappings = 1
do
  vim.keymap.set("o", "ac", "<Plug>(textobj-between-a)", {})
  vim.keymap.set("v", "ac", "<Plug>(textobj-between-a)", {})
end
do
  vim.keymap.set("o", "ic", "<Plug>(textobj-between-i)", {})
  vim.keymap.set("v", "ic", "<Plug>(textobj-between-i)", {})
end
do
  vim.keymap.set("o", "ab", "<Plug>(textobj-multiblock-a)", {})
  vim.keymap.set("v", "ab", "<Plug>(textobj-multiblock-a)", {})
end
vim.keymap.set("o", "ib", "<Plug>(textobj-multiblock-i)", {})
return vim.keymap.set("v", "ib", "<Plug>(textobj-multiblock-i)", {})
