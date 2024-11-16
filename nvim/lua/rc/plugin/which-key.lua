-- [nfnl] Compiled from fnl/rc/plugin/which-key.fnl by https://github.com/Olical/nfnl, do not edit.
local wk = require("which-key")
local function which_key_show()
  return wk.show({global = false})
end
return vim.keymap.set("n", "<leader>?", which_key_show, {})
