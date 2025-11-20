-- [nfnl] fnl/rc/plugin/snacks.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local snacks = require("snacks")
local picker_sources = require("snacks.picker.config.sources")
local trouble_source_snacks = autoload("trouble.sources.snacks")
local function _2_(self)
  local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
  if (f == "") then
    return Snacks.notify.warn("No file under cursor")
  else
    self:hide()
    local function _3_()
      return vim.cmd(("e " .. f))
    end
    return vim.schedule(_3_)
  end
end
local function _5_(self)
  return vim.cmd("stopinsert")
end
snacks.setup({bigfile = {enabled = true}, image = {enabled = true, doc = {float = true, inline = false}}, input = {}, indent = {enabled = true}, notifier = {enabled = true}, picker = {actions = trouble_source_snacks.actions, win = {input = {keys = {["<c-t>"] = {"trouble_open", mode = {"n", "i"}}}}}}, quickfile = {enabled = true}, terminal = {win = {style = {bo = {filetype = "snacks_terminal"}, wo = {}, keys = {gf = _2_, term_normal = {"<esc>", _5_, mode = "t", expr = true, desc = "escape to normal mode"}}}}}})
local function map__3e(toggle, key)
  return toggle:map(key)
end
map__3e(snacks.toggle.option("spell", {name = "spelling"}), "<leader>s")
map__3e(snacks.toggle.option("paste", {name = "Paste"}), "<leader>p")
map__3e(snacks.toggle.option("relativenumber", {name = "Relative number"}), "<leader>r")
map__3e(snacks.toggle.inlay_hints(), "<leader>i")
vim.keymap.set("n", "<leader>w", ":<C-u>lua Snacks.terminal.toggle()<CR>", {silent = true, desc = "Open/Close terminal"})
vim.keymap.set("n", "<leader>t", ":<C-u>lua Snacks.picker.explorer({ hidden = true, ignored = true })<CR>", {silent = true, desc = "Open/Close explorer"})
vim.keymap.set("n", ",b", ":<C-u>lua Snacks.picker.buffers()<CR>", {silent = true, desc = "select buffer via snacks.picker"})
vim.keymap.set("n", ",c", ":<C-u>lua Snacks.picker.command_history()<CR>", {silent = true, desc = "select command from history via snacks.picker"})
vim.keymap.set("n", ",f", ":<C-u>lua Snacks.picker.files()<CR>", {silent = true, desc = "select file via snacks.picker"})
vim.keymap.set("n", ",af", ":<C-u>lua Snacks.picker.files({ hidden = true, ignored = true })<CR>", {silent = true, desc = "select all file via snacks.picker"})
vim.keymap.set("n", ",g", ":<C-u>lua Snacks.picker.grep()<CR>", {silent = true, desc = "live grep via snacks.picker"})
vim.keymap.set("n", ",gf", ":<C-u>lua Snacks.picker.git_files()<CR>", {silent = true, desc = "select git file via snacks.picker"})
vim.keymap.set("n", ",gg", ":<C-u>lua Snacks.picker.git_grep()<CR>", {silent = true, desc = "git-grep via snacks.picker"})
vim.keymap.set("n", ",gb", ":<C-u>lua Snacks.picker.git_branches()<CR>", {silent = true, desc = "switch git branch via snacks.picker"})
vim.keymap.set("n", ",gc", ":<C-u>lua Snacks.picker.git_log()<CR>", {silent = true, desc = "select git commit via snacks.picker"})
vim.keymap.set("n", ",h", ":<C-u>lua Snacks.picker.help()<CR>", {silent = true, desc = "search helptags via snacks.picker"})
vim.keymap.set("n", ",u", ":<C-u>lua Snacks.picker.undo()<CR>", {silent = true, desc = "undo history via snacks.picker"})
vim.keymap.set("n", ",/", ":<C-u>lua Snacks.picker.lines()<CR>", {silent = true, desc = "line search via snacks.picker"})
vim.keymap.set("n", "<Leader><Leader>", ":<C-u>lua Snacks.picker.commands()<CR>", {silent = true, desc = "select commands via snacks.picker"})
vim.keymap.set("n", "<C-\\>", ":<C-u>lua Snacks.picker()<CR>", {silent = true, desc = "select snacks.picker source"})
local kensaku_finder
local function _6_(opts, ctx)
  if (ctx.filter.search == "") then
    local function _7_()
    end
    return _7_
  else
    local cwd
    if not opts.buffers then
      local function _8_()
        if (opts and opts.cwd) then
          return opts.cwd
        else
          return (vim.uv.cwd() or ".")
        end
      end
      cwd = svim.fs.normalize(_8_())
    else
      cwd = nil
    end
    local paths
    if opts.buffers then
      local function _10_(x)
        return not core["nil?"](x)
      end
      local function _11_()
        local tbl_26_ = {}
        local i_27_ = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          local val_28_
          do
            local name = vim.api.nvim_buf_get_name(buf)
            local and_12_ = (name ~= "")
            if and_12_ then
              local b = core.get(vim.bo, buf)
              and_12_ = b.buflisted
            end
            if (and_12_ and vim.uv.fs_stat(name)) then
              val_28_ = name
            else
              val_28_ = nil
            end
          end
          if (nil ~= val_28_) then
            i_27_ = (i_27_ + 1)
            tbl_26_[i_27_] = val_28_
          else
          end
        end
        return tbl_26_
      end
      paths = core.map(svim.fs.normalize, core.filter(_10_, _11_()))
    else
      paths = {}
    end
    local pattern = snacks.picker.util.parse(ctx.filter.search)
    local kensaku_pattern = vim.fn["kensaku#query"](pattern, {rxop = vim.g["kensaku#rxop#javascript"]})
    local args = core.concat({"--color=never", "--no-heading", "--no-ignore", "--with-filename", "--line-number", "--column", "--smart-case", "--max-columns=500", "--max-columns-preview", "-g", "!.git", "--hidden", "-L", "--", kensaku_pattern}, paths)
    local proc = require("snacks.picker.source.proc")
    local transform
    local function _17_(item)
      item.cwd = cwd
      local file, line, col, text = item.text:match("^(.+):(%d+):(%d+):(.*)$")
      if not file then
        if not item.text:match("WARNING") then
          snacks.notify.error(("invalid grep output:\n" .. item.text))
        else
        end
        return false
      else
        item.line = text
        item.file = file
        item.pos = {tonumber(line), tonumber(core.dec(col))}
        return nil
      end
    end
    transform = _17_
    return proc.proc(ctx:opts({cmd = "rg", args = args, transform = transform, notify = false}), ctx)
  end
end
kensaku_finder = _6_
picker_sources.kensaku = {finder = kensaku_finder, regex = true, format = "file", show_empty = true, live = true, supports_live = true}
vim.keymap.set("n", ",k", ":<C-u>lua Snacks.picker.kensaku()<CR>", {silent = true, desc = "live kensaku via snacks.picker"})
picker_sources.klines = {finder = kensaku_finder, regex = true, format = "file", show_empty = true, live = true, supports_live = true, buffers = true, layout = {preview = "main", preset = "ivy"}}
vim.keymap.set("n", ",K", ":<C-u>lua Snacks.picker.klines()<CR>", {silent = true, desc = "live kensaku for buffers via snacks.picker"})
local function _21_(ft)
  return {name = ft, text = ft}
end
local function _22_(item)
  local util = require("snacks.util")
  local icon, hl = util.icon(item.text, "filetype")
  return {{(icon .. " "), hl}, {item.text}}
end
local function _23_(picker, item)
  picker:close()
  return vim.cmd.set(("ft=" .. item.text))
end
picker_sources.filetype = {items = core.map(_21_, vim.fn.getcompletion("", "filetype")), source = "filetype", layout = "select", format = _22_, confirm = _23_}
return vim.keymap.set("n", ",t", ":<C-u>lua Snacks.picker.filetype()<CR>", {silent = true, desc = "select filetype via snacks.picker"})
