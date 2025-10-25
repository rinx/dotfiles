-- [nfnl] fnl/rc/mapping.fnl
vim.g.mapleader = "\\"
do
  vim.keymap.set("n", ";", ":", {})
  vim.keymap.set("v", ";", ":", {})
end
do
  vim.keymap.set("n", ":", ";", {})
  vim.keymap.set("v", ":", ";", {})
end
do
  vim.keymap.set("n", "<Left>", "<Nop>", {})
  vim.keymap.set("i", "<Left>", "<Nop>", {})
end
do
  vim.keymap.set("n", "<Down>", "<Nop>", {})
  vim.keymap.set("i", "<Down>", "<Nop>", {})
end
do
  vim.keymap.set("n", "<Up>", "<Nop>", {})
  vim.keymap.set("i", "<Up>", "<Nop>", {})
end
do
  vim.keymap.set("n", "<Right>", "<Nop>", {})
  vim.keymap.set("i", "<Right>", "<Nop>", {})
end
vim.keymap.set("n", "<C-t>", "<Nop>", {})
do
  vim.keymap.set("n", "j", "gj", {silent = true})
  vim.keymap.set("v", "j", "gj", {silent = true})
  vim.keymap.set("o", "j", "gj", {silent = true})
end
do
  vim.keymap.set("n", "k", "gk", {silent = true})
  vim.keymap.set("v", "k", "gk", {silent = true})
  vim.keymap.set("o", "k", "gk", {silent = true})
end
vim.keymap.set("n", "0", "g0", {silent = true})
vim.keymap.set("n", "$", "g$", {silent = true})
do
  vim.keymap.set("n", "gj", "j", {silent = true})
  vim.keymap.set("v", "gj", "j", {silent = true})
  vim.keymap.set("o", "gj", "j", {silent = true})
end
do
  vim.keymap.set("n", "gk", "k", {silent = true})
  vim.keymap.set("v", "gk", "k", {silent = true})
  vim.keymap.set("o", "gk", "k", {silent = true})
end
vim.keymap.set("n", "g0", "0", {silent = true})
vim.keymap.set("n", "g$", "$", {silent = true})
vim.keymap.set("n", "Y", "y$", {})
vim.keymap.set("n", ",p", "\"+p", {})
vim.keymap.set("n", ",P", "\"+P", {})
do
  vim.keymap.set("n", ",y", "\"+y", {})
  vim.keymap.set("v", ",y", "\"+y", {})
end
do
  vim.keymap.set("n", ",d", "\"+d", {})
  vim.keymap.set("v", ",d", "\"+d", {})
end
vim.keymap.set("c", "<C-p>", "<Up>", {})
vim.keymap.set("c", "<C-n>", "<Down>", {})
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", {silent = true})
vim.keymap.set("n", "s", "<Nop>", {})
vim.keymap.set("n", "S", "<Nop>", {})
vim.keymap.set("n", "sj", "<C-w>j<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sk", "<C-w>k<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sl", "<C-w>l<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sh", "<C-w>h<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sJ", "<C-w>J<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sK", "<C-w>K<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sL", "<C-w>L<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sH", "<C-w>H<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "s>", "<C-w>><Plug>(winnav)", {silent = true})
vim.keymap.set("n", "s<", "<C-w><<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "s+", "<C-w>+<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "s-", "<C-w>-<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)j", "<C-w>j<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)k", "<C-w>k<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)l", "<C-w>l<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)h", "<C-w>h<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)J", "<C-w>J<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)K", "<C-w>K<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)L", "<C-w>L<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)H", "<C-w>H<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)>", "<C-w>><Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)<", "<C-w><<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)+", "<C-w>+<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "<Plug>(winnav)-", "<C-w>-<Plug>(winnav)", {silent = true})
vim.keymap.set("n", "sr", "<C-w>r", {silent = true})
vim.keymap.set("n", "sw", "<C-w>w", {silent = true})
vim.keymap.set("n", "so", "<C-w>_<C-w>\22|", {silent = true})
vim.keymap.set("n", "sO", "<C-w>=", {silent = true})
vim.keymap.set("n", "s=", "<C-w>=", {silent = true})
vim.keymap.set("n", "ss", ":<C-u>sp<CR>", {silent = true})
vim.keymap.set("n", "sv", ":<C-u>vs<CR>", {silent = true})
vim.keymap.set("n", "MM", "zz", {})
vim.keymap.set("n", "ZZ", "<Nop>", {})
vim.keymap.set("n", "ZQ", "<Nop>", {})
vim.keymap.set("n", "Q", "<Nop>", {})
vim.keymap.set("n", "H", "H<Plug>(H)", {})
vim.keymap.set("n", "L", "L<Plug>(L)", {})
vim.keymap.set("n", "<Plug>(H)H", "<PageUp><Plug>(H)", {})
return vim.keymap.set("n", "<Plug>(L)L", "<PageDown><Plug>(L)", {})
