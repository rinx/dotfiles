-- [nfnl] Compiled from fnl/rc/plugin/snacks.fnl by https://github.com/Olical/nfnl, do not edit.
local snacks = require("snacks")
local function _1_(self)
  local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
  if (f == "") then
    return Snacks.notify.warn("No file under cursor")
  else
    self:hide()
    local function _2_()
      return vim.cmd(("e " .. f))
    end
    return vim.schedule(_2_)
  end
end
local function _4_(self)
  return vim.cmd("stopinsert")
end
snacks.setup({bigfile = {enabled = true}, image = {enabled = true}, input = {}, notifier = {enabled = true}, picker = {}, quickfile = {enabled = true}, terminal = {win = {style = {bo = {filetype = "snacks_terminal"}, wo = {}, keys = {gf = _1_, term_normal = {"<esc>", _4_, mode = "t", expr = true, desc = "escape to normal mode"}}}}}})
local function map__3e(toggle, key)
  return toggle:map(key)
end
map__3e(snacks.toggle.option("spell", {name = "spelling"}), "<leader>s")
map__3e(snacks.toggle.option("paste", {name = "Paste"}), "<leader>p")
map__3e(snacks.toggle.option("relativenumber", {name = "Relative number"}), "<leader>r")
map__3e(snacks.toggle.inlay_hints(), "<leader>i")
vim.keymap.set("n", "<leader>w", ":<C-u>lua Snacks.terminal.toggle()<CR>", {silent = true, desc = "Open/Close terminal"})
vim.keymap.set("n", "<leader>t", ":<C-u>lua Snacks.picker.explorer()<CR>", {silent = true, desc = "Open/Close explorer"})
vim.keymap.set("n", ",b", ":<C-u>lua Snacks.picker.buffers()<CR>", {silent = true, desc = "select buffer via snacks.picker"})
vim.keymap.set("n", ",c", ":<C-u>lua Snacks.picker.command_history()<CR>", {silent = true, desc = "select command from history via snacks.picker"})
vim.keymap.set("n", ",f", ":<C-u>lua Snacks.picker.files()<CR>", {silent = true, desc = "select file via snacks.picker"})
vim.keymap.set("n", ",af", ":<C-u>lua Snacks.picker.files({ hidden = true, ignored = true })<CR>", {silent = true, desc = "select all file via snacks.picker"})
vim.keymap.set("n", ",g", ":<C-u>lua Snacks.picker.grep()<CR>", {silent = true, desc = "live grep via snacks.picker"})
vim.keymap.set("n", ",gf", ":<C-u>lua Snacks.picker.git_files()<CR>", {silent = true, desc = "select git file via snacks.picker"})
vim.keymap.set("n", ",gb", ":<C-u>lua Snacks.picker.git_branches()<CR>", {silent = true, desc = "switch git branch via snacks.picker"})
vim.keymap.set("n", ",gc", ":<C-u>lua Snacks.picker.git_log()<CR>", {silent = true, desc = "select git commit via snacks.picker"})
vim.keymap.set("n", ",h", ":<C-u>lua Snacks.picker.help()<CR>", {silent = true, desc = "search helptags via snacks.picker"})
vim.keymap.set("n", ",/", ":<C-u>lua Snacks.picker.lines()<CR>", {silent = true, desc = "line search via snacks.picker"})
vim.keymap.set("n", "<Leader><Leader>", ":<C-u>lua Snacks.picker.commands()<CR>", {silent = true, desc = "select commands via snacks.picker"})
return vim.keymap.set("n", "<C-\\>", ":<C-u>lua Snacks.picker()<CR>", {silent = true, desc = "select snacks.picker source"})
