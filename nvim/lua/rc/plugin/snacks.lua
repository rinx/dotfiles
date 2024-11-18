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
snacks.setup({terminal = {win = {style = {bo = {filetype = "snacks_terminal"}, wo = {}, keys = {gf = _1_, term_normal = {"<esc>", _4_, mode = "t", expr = true, desc = "escape to normal mode"}}}}}})
return vim.keymap.set("n", "<leader>w", ":<C-u>lua Snacks.terminal.toggle()<CR>", {silent = true, desc = "Open/Close terminal"})
