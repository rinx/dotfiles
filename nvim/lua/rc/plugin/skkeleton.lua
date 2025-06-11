-- [nfnl] fnl/rc/plugin/skkeleton.fnl
vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)", {})
vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)", {})
local function initialize()
  return vim.fn["skkeleton#config"]({globalDictionaries = {"~/.SKK-JISYO.L"}, immediatelyDictionaryRW = true, keepState = true, selectCandidateKeys = "asdfjkl", setUndoPoint = true, showCandidatesCount = 4, userDictionary = "~/.skk-jisyo", databasePath = "~/.cache/nvim/skkeleton.db", sources = {"deno_kv", "skk_dictionary"}, eggLikeNewline = false, registerConvertResult = false})
end
local group_5_auto = vim.api.nvim_create_augroup("init-skkeleton", {clear = true})
vim.api.nvim_create_autocmd({"User"}, {callback = initialize, group = group_5_auto, pattern = "skkeleton-initialize-pre"})
vim.api.nvim_create_autocmd({"User"}, {command = "redrawstatus", group = group_5_auto, pattern = "skkeleton-mode-changed"})
local function _1_()
  vim.b.completion = false
  return nil
end
vim.api.nvim_create_autocmd({"User"}, {callback = _1_, group = group_5_auto, pattern = "skkeleton-enable-pre"})
local function _2_()
  vim.b.completion = true
  return nil
end
return vim.api.nvim_create_autocmd({"User"}, {callback = _2_, group = group_5_auto, pattern = "skkeleton-disable-pre"})
