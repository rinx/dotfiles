-- [nfnl] Compiled from fnl/rc/plugin/skkeleton.fnl by https://github.com/Olical/nfnl, do not edit.
vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)", {})
vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)", {})
local function initialize()
  return vim.fn["skkeleton#config"]({globalDictionaries = {"~/.SKK-JISYO.L"}, immediatelyDictionaryRW = true, keepState = true, selectCandidateKeys = "asdfjkl", setUndoPoint = true, showCandidatesCount = 4, usePopup = true, userDictionary = "~/.skk-jisyo", eggLikeNewline = false, registerConvertResult = false})
end
local group_5_auto = vim.api.nvim_create_augroup("init-skkeleton", {clear = true})
vim.api.nvim_create_autocmd({"User"}, {callback = initialize, group = group_5_auto, pattern = "skkeleton-initialize-pre"})
return vim.api.nvim_create_autocmd({"User"}, {command = "redrawstatus", group = group_5_auto, pattern = "skkeleton-mode-changed"})
