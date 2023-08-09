-- [nfnl] Compiled from fnl/rc/plugin/actions-preview.fnl by https://github.com/Olical/nfnl, do not edit.
local actions_preview = require("actions-preview")
local function _1_(...)
  vim.keymap.set("n", "<Leader>A", ":<C-u>lua require'actions-preview'.code_actions()<CR>", {silent = true})
  return vim.keymap.set("v", "<Leader>A", ":<C-u>lua require'actions-preview'.code_actions()<CR>", {silent = true})
end
return actions_preview.setup({backend = {"nui", "telescope"}, nui = {dir = "row"}}, _1_(...))
