-- [nfnl] Compiled from fnl/rc/plugin/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("blink.cmp")
local mini_snippets = require("mini.snippets")
local function _1_()
  return vim.tbl_contains({"gitcommit", "markdown"}, vim.bo.filetype)
end
local function _2_()
  return vim.tbl_contains({"octo", "gitcommit", "markdown"}, vim.bo.filetype)
end
cmp.setup({keymap = {preset = "default"}, sources = {default = {"lsp", "path", "snippets", "buffer", "ripgrep", "emoji", "git"}, providers = {ripgrep = {module = "blink-ripgrep", name = "Ripgrep"}, emoji = {module = "blink-emoji", name = "Emoji", score_offset = 15, opts = {insert = true}, should_show_items = _1_}, git = {module = "blink-cmp-git", name = "Git", enabled = _2_}}}, snippets = {preset = "mini_snippets"}})
return mini_snippets.setup({snippets = {mini_snippets.gen_loader.from_lang()}, mappings = {expand = "<C-i>"}})
