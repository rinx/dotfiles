-- [nfnl] Compiled from fnl/rc/plugin/lightspeed.fnl by https://github.com/Olical/nfnl, do not edit.
local lightspeed = require("lightspeed")
lightspeed.setup({match_only_the_start_of_same_char_seqs = true, limit_ft_matches = 5})
vim.keymap.set("n", "z", "<Plug>Lightspeed_s", {})
vim.keymap.set("n", "Z", "<Plug>Lightspeed_S", {})
return vim.keymap.set("n", "<C-x>", "<Plug>Lightspeed_x", {})
