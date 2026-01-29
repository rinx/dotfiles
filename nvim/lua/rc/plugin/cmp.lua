-- [nfnl] fnl/rc/plugin/cmp.fnl
local cmp = require("blink.cmp")
local mini_snippets = require("mini.snippets")
local function _1_()
  local buftype = vim.api.nvim_buf_get_option(0, "buftype")
  local bufname = vim.api.nvim_buf_get_name(0)
  return (not (buftype == "prompt") and not (bufname:match("org%-roam%-select$") ~= nil))
end
local function _2_()
  return vim.tbl_contains({"gitcommit", "markdown"}, vim.bo.filetype)
end
local function _3_()
  return vim.tbl_contains({"octo", "gitcommit", "markdown"}, vim.bo.filetype)
end
local function _4_(ctx)
  return ((ctx.mode ~= "cmdline") or not vim.tbl_contains({"/", "?"}, vim.fn.getcmdtype()))
end
local function _5_(ctx)
  return (ctx.mode ~= "cmdline")
end
local function _6_(ctx)
  return (ctx.mode ~= "cmdline")
end
cmp.setup({enabled = _1_, keymap = {preset = "enter"}, sources = {default = {"lsp", "path", "snippets", "buffer", "ripgrep", "emoji", "git", "avante", "copilot"}, providers = {ripgrep = {module = "blink-ripgrep", name = "Ripgrep"}, emoji = {module = "blink-emoji", name = "Emoji", score_offset = 15, opts = {insert = true}, should_show_items = _2_}, git = {module = "blink-cmp-git", name = "Git", enabled = _3_}, avante = {name = "avante", module = "blink-cmp-avante"}, copilot = {name = "copilot", module = "blink-cmp-copilot", score_offset = 100, async = true}}}, completion = {documentation = {auto_show = true, auto_show_delay_ms = 500}, menu = {auto_show = _4_}, list = {selection = {preselect = _5_, auto_insert = _6_}}}, cmdline = {keymap = {["<C-n>"] = {"select_next", "fallback"}, ["<C-p>"] = {"select_prev", "fallback"}, ["<CR>"] = {"accept", "fallback"}}}, snippets = {preset = "mini_snippets"}})
return mini_snippets.setup({snippets = {mini_snippets.gen_loader.from_lang()}, mappings = {expand = "<C-i>"}})
