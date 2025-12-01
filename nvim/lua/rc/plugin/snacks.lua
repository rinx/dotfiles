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
vim.keymap.set("n", ",x", ":<C-u>lua Snacks.picker.diagnostics()<CR>", {silent = true, desc = "select diagnostics via snacks.picker"})
vim.keymap.set("n", ",f", ":<C-u>lua Snacks.picker.files()<CR>", {silent = true, desc = "select file via snacks.picker"})
vim.keymap.set("n", ",af", ":<C-u>lua Snacks.picker.files({ hidden = true, ignored = true })<CR>", {silent = true, desc = "select all file via snacks.picker"})
vim.keymap.set("n", ",g", ":<C-u>lua Snacks.picker.grep()<CR>", {silent = true, desc = "live grep via snacks.picker"})
vim.keymap.set("n", ",gf", ":<C-u>lua Snacks.picker.git_files()<CR>", {silent = true, desc = "select git file via snacks.picker"})
vim.keymap.set("n", ",gg", ":<C-u>lua Snacks.picker.git_grep()<CR>", {silent = true, desc = "git-grep via snacks.picker"})
vim.keymap.set("n", ",gb", ":<C-u>lua Snacks.picker.git_branches()<CR>", {silent = true, desc = "switch git branch via snacks.picker"})
vim.keymap.set("n", ",gc", ":<C-u>lua Snacks.picker.git_log()<CR>", {silent = true, desc = "select git commit via snacks.picker"})
vim.keymap.set("n", ",ghi", ":<C-u>lua Snacks.picker.gh_issue()<CR>", {silent = true, desc = "select github issue via snacks.picker"})
vim.keymap.set("n", ",ghp", ":<C-u>lua Snacks.picker.gh_pr()<CR>", {silent = true, desc = "select github pr via snacks.picker"})
vim.keymap.set("n", ",h", ":<C-u>lua Snacks.picker.help()<CR>", {silent = true, desc = "search helptags via snacks.picker"})
vim.keymap.set("n", ",r", ":<C-u>lua Snacks.picker.resume()<CR>", {silent = true, desc = "resume last picker"})
vim.keymap.set("n", ",s", ":<C-u>lua Snacks.picker.search_history()<CR>", {silent = true, desc = "select search history via snacks.picker"})
vim.keymap.set("n", ",u", ":<C-u>lua Snacks.picker.undo()<CR>", {silent = true, desc = "undo history via snacks.picker"})
vim.keymap.set("n", ",/", ":<C-u>lua Snacks.picker.lines()<CR>", {silent = true, desc = "line search via snacks.picker"})
vim.keymap.set("n", "<Leader><Leader>", ":<C-u>lua Snacks.picker.commands({ layout = { preset = \"vscode\"}})<CR>", {silent = true, desc = "select commands via snacks.picker"})
vim.keymap.set("n", "<C-\\>", ":<C-u>lua Snacks.picker()<CR>", {silent = true, desc = "select snacks.picker source"})
local kensaku_finder
local function _6_(opts, ctx)
  if (ctx.filter.search == "") then
    if opts["current-buf"] then
      local l = require("snacks.picker.source.lines")
      return l.lines(opts, ctx)
    else
      local function _7_()
      end
      return _7_
    end
  else
    local cwd
    if not opts["current-buf"] then
      local function _9_()
        if (opts and opts.cwd) then
          return opts.cwd
        else
          return (vim.uv.cwd() or ".")
        end
      end
      cwd = svim.fs.normalize(_9_())
    else
      cwd = nil
    end
    local buf
    do
      local buf0 = ctx.filter.current_buf
      if (buf0 == 0) then
        buf = vim.api.nvim_get_current_buf()
      else
        buf = buf0
      end
    end
    local paths
    if opts["current-buf"] then
      local name = vim.api.nvim_buf_get_name(buf)
      if vim.uv.fs_stat(name) then
        paths = {svim.fs.normalize(name)}
      else
        paths = {}
      end
    else
      paths = {}
    end
    local extmarks
    if opts["current-buf"] then
      local hl = require("snacks.picker.util.highlight")
      extmarks = hl.get_highlights({buf = buf, extmarks = true})
    else
      extmarks = nil
    end
    local pattern = snacks.picker.util.parse(ctx.filter.search)
    local kensaku_pattern = vim.fn["kensaku#query"](pattern, {rxop = vim.g["kensaku#rxop#javascript"]})
    local args = core.concat({"--color=never", "--no-heading", "--no-ignore", "--with-filename", "--line-number", "--column", "--smart-case", "--max-columns=500", "--max-columns-preview", "-g", "!.git", "--hidden", "-L", "--", kensaku_pattern}, paths)
    local proc = require("snacks.picker.source.proc")
    local transform
    local function _15_(item)
      item.cwd = cwd
      local file, line, col, text = item.text:match("^(.+):(%d+):(%d+):(.*)$")
      if not file then
        if not item.text:match("WARNING") then
          snacks.notify.error(("invalid grep output:\n" .. item.text))
        else
        end
        return false
      else
        if opts["current-buf"] then
          item.buf = buf
          item.text = text
          item.pos = {tonumber(line), tonumber(core.dec(col))}
          if extmarks then
            item.highlights = core.get(extmarks, tonumber(line))
            return nil
          else
            return nil
          end
        else
          item.line = text
          item.file = file
          item.pos = {tonumber(line), tonumber(core.dec(col))}
          return nil
        end
      end
    end
    transform = _15_
    return proc.proc(ctx:opts({cmd = "rg", args = args, transform = transform, notify = false}), ctx)
  end
end
kensaku_finder = _6_
picker_sources.kensaku = {finder = kensaku_finder, regex = true, format = "file", show_empty = true, live = true, supports_live = true}
vim.keymap.set("n", ",k", ":<C-u>lua Snacks.picker.kensaku()<CR>", {silent = true, desc = "live kensaku via snacks.picker"})
picker_sources.klines = {finder = kensaku_finder, regex = true, format = "lines", show_empty = true, live = true, supports_live = true, ["current-buf"] = true, layout = {preview = "main", preset = "ivy"}}
vim.keymap.set("n", ",K", ":<C-u>lua Snacks.picker.klines()<CR>", {silent = true, desc = "live kensaku for current buffer via snacks.picker"})
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
vim.keymap.set("n", ",t", ":<C-u>lua Snacks.picker.filetype()<CR>", {silent = true, desc = "select filetype via snacks.picker"})
local confirm_cmd
local function _24_(picker, item)
  picker:close()
  if (item and item.cmd) then
    vim.fn.histadd("cmd", item.cmd)
    return vim.cmd(item.cmd)
  else
    return nil
  end
end
confirm_cmd = _24_
picker_sources.command_history.confirm = confirm_cmd
picker_sources.commands.confirm = confirm_cmd
local custom_actions = {"cd %:p:h", "lua Snacks.git.blame_line()", "lua Snacks.gitbrowse()", "lua Snacks.lazygit()", "lua Snacks.notifier.hide()", "lua Snacks.notifier.show_history()", "lua Snacks.picker.gh_issue()", "lua Snacks.picker.gh_issue({ state = \"all\" })", "lua Snacks.picker.gh_pr()", "lua Snacks.picker.gh_pr({ state = \"all\" })", "lua Snacks.picker.notifications()", "lua Snacks.terminal.toggle()", "lua Snacks.terminal.open()", "AvanteAsk", "AvanteChat", "AvanteToggle", "ConjureConnect", "ConjureLogSplit", "ConjureLogVSplit", "ConjureCljDebugInit", "DapContinue", "DapListBreakpoints", "DapStepInto", "DapStepOut", "DapStepOver", "DapToggleBreakpoint", "DapViewToggle", "Ghq", "Inspect", "InspectTree", "Lazy", "Lazy check", "Lazy update", "Lazy profile", "LspInfo", "LspRestart", "LspStart", "LspStop", "MCPHub", "OrgFind", "OrgGrep", "OrgKensaku", "OrgInbox", "OrgJournal", "OrgRefileToToday", "PasteImage", "RoamCommitPush", "RoamGrep", "RoamKensaku", "RoamPull", "RoamRefreshSearchIndex", "RoamReset", "RoamStatus", "Telescope dap list_breakpoints", "Telescope repo list", "Telescope orgmode refile_heading", "Telescope orgmode search_headings", "Telescope orgmode insert_link", "TelescopeRoamNodesByTag book", "TelescopeRoamNodesByTag code", "TelescopeRoamNodesByTag fleeting", "TelescopeRoamNodesByTag project", "TelescopeRoamNodesByTag scrap", "TelescopeRoamNodesByTag wiki", "Trouble diagnostics", "Trouble loclist", "Trouble lsp", "Trouble lsp_references", "Trouble quickfix", "Trouble snacks", "Trouble snacks_files", "Trouble todo"}
local function _26_(cmd)
  return {name = cmd, text = cmd, cmd = cmd}
end
local function _27_(item)
  return {{}, {item.name}}
end
picker_sources.custom_actions = {items = core.map(_26_, custom_actions), layout = {preset = "vscode"}, preview = "none", format = _27_, confirm = confirm_cmd}
return vim.keymap.set("n", "<Leader>h", ":<C-u>lua Snacks.picker.custom_actions()<CR>", {silent = true, desc = "select custom action via snacks.picker"})
