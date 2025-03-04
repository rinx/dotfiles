-- [nfnl] Compiled from fnl/rc/plugin/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local heirline = autoload("heirline")
local conditions = autoload("heirline.conditions")
local utils = autoload("heirline.utils")
local devicons = autoload("nvim-web-devicons")
local dap = autoload("dap")
local color = autoload("rc.color")
local icon = autoload("rc.icon")
local colors = color.colors
local icontab = icon.tab
local palette = {bright_bg = colors.color2, bright_fg = colors.color4, red = colors.error, dark_red = colors.color8, green = colors.info, blue = colors.hint, gray = colors.color4, orange = colors.warn, purple = colors.purple, cyan = colors.color10, diag_warn = colors.warn, diag_error = colors.error, diag_hint = colors.hint, diag_info = colors.info, git_del = colors.color8, git_add = colors.color13, git_change = colors.warn}
local space = " "
local fill = "\226\150\138"
local space_component = {provider = space}
local align_component = {provider = "%="}
local vi_mode_component
local function _2_(self)
  self.mode = vim.fn.mode(1)
  return nil
end
local function _3_(self)
  local m = self.mode:sub(1, 1)
  return {fg = core.get(self.colors, m), bg = colors.color2, bold = true}
end
local function _4_()
  return vim.cmd("redrawstatus")
end
vi_mode_component = {init = _2_, static = {colors = {n = colors.info, i = colors.error, v = colors.color8, V = colors.color8, [{"\22"}] = colors.color8, c = colors.info, s = colors.warn, S = colors.warn, [{"\19"}] = colors.warn, R = colors.purple, r = colors.purple, [{"!"}] = colors.info, t = colors.info}}, provider = fill, hl = _3_, update = {"ModeChanged", pattern = "*:*", callback = vim.schedule_wrap(_4_)}}
local file_icon_component
local function _5_(self)
  local filename = self.filename
  local extension = vim.fn.fnamemodify(filename, ":e")
  local icon0, color0 = devicons.get_icon_color(filename, extension, {default = true})
  self.icon = icon0
  self["icon-color"] = color0
  return nil
end
local function _6_(self)
  if self.icon then
    return self.icon
  else
    return nil
  end
end
local function _8_(self)
  return {fg = self["icon-color"], bg = colors.color2}
end
file_icon_component = {init = _5_, provider = _6_, hl = _8_}
local filename_component
local function _9_(self)
  local filename = vim.fn.fnamemodify(self.filename, ":.")
  if core["empty?"](filename) then
    return "[No Name]"
  else
    if conditions.width_percent_below(core.count(filename), 0.25) then
      return filename
    else
      local shortened = vim.fn.pathshorten(filename)
      if conditions.width_percent_below(core.count(shortened), 0.25) then
        return shortened
      else
        return vim.fn.fnamemodify(self.filename, ":p:t")
      end
    end
  end
end
filename_component = {provider = _9_, hl = {fg = colors.hint, bg = colors.color2, bold = true}}
local file_flags_component
local function _13_()
  return vim.bo.modified
end
local function _14_()
  return (not vim.bo.modifiable or vim.bo.readonly)
end
file_flags_component = {{condition = _13_, provider = (space .. icontab.circle), hl = {fg = colors.hint, bg = colors.color2}}, {condition = _14_, provider = (space .. icontab.lock), hl = {fg = colors.hint, bg = colors.color2}}}
local filename_block
local function _15_(self)
  self.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
filename_block = {file_icon_component, space_component, filename_component, file_flags_component, init = _15_}
local cwd_component
local function _16_()
  local shorten
  local function _17_(cwd)
    if conditions.width_percent_below(core.count(cwd), 0.25) then
      return cwd
    else
      return vim.fn.pathshorten(cwd)
    end
  end
  shorten = _17_
  local trail
  local function _19_(cwd)
    if (cwd:sub(-1) == "/") then
      return cwd
    else
      return (cwd .. "/")
    end
  end
  trail = _19_
  local cwd = trail(shorten(vim.fn.fnamemodify(vim.fn.getcwd(0), ":~")))
  return (icontab.directory .. space .. cwd .. space)
end
cwd_component = {provider = _16_, hl = {fg = colors.hint}}
local ruler_component = {provider = "[%l/%L] ", hl = {fg = colors.hint, bg = colors.color2}}
local scrollbar_component
local function _21_(self)
  local curr_line = core.get(vim.api.nvim_win_get_cursor(0), 1)
  local lines = vim.api.nvim_buf_line_count(0)
  local i = core.inc(math.floor(((core.dec(curr_line) / lines) * core.count(self.sbar))))
  return string.rep(core.get(self.sbar, i), 2)
end
scrollbar_component = {static = {sbar = {"\240\159\173\182", "\240\159\173\183", "\240\159\173\184", "\240\159\173\185", "\240\159\173\186", "\240\159\173\187"}}, provider = _21_, hl = {fg = colors.hint, bg = colors.color2}}
local lsp_component
local function _22_()
  local clients = core.count(vim.lsp.get_clients({bufnr = 0}))
  if (clients >= 2) then
    return (icontab.compas .. clients)
  else
    return icontab.compas
  end
end
local function _24_()
  local function _25_()
    return vim.cmd("LspInfo")
  end
  return vim.defer_fn(_25_, 100)
end
lsp_component = {condition = conditions.lsp_attached, update = {"LspAttach", "LspDetach"}, provider = _22_, on_click = {callback = _24_, name = "heirline_LSP"}, hl = {fg = colors.info}}
local diagnostics_component
local function _26_(self)
  if (self.errors > 0) then
    return (icontab.bug .. self.errors .. space)
  else
    return nil
  end
end
local function _28_(self)
  if (self.warns > 0) then
    return (icontab["exclam-circle"] .. self.warns .. space)
  else
    return nil
  end
end
local function _30_(self)
  if (self.infos > 0) then
    return (icontab["info-circle"] .. self.infos .. space)
  else
    return nil
  end
end
local function _32_(self)
  if (self.hints > 0) then
    return (icontab.leaf .. self.hints .. space)
  else
    return nil
  end
end
local function _34_(self)
  local dc
  local function _35_(severity)
    return core.count(vim.diagnostic.get(0, {severity = severity}))
  end
  dc = _35_
  self.errors = dc(vim.diagnostic.severity.ERROR)
  self.warns = dc(vim.diagnostic.severity.WARN)
  self.infos = dc(vim.diagnostic.severity.INFO)
  self.hints = dc(vim.diagnostic.severity.HINT)
  return nil
end
diagnostics_component = {{provider = _26_, hl = {fg = "diag_error"}}, {provider = _28_, hl = {fg = "diag_warn"}}, {provider = _30_, hl = {fg = "diag_info"}}, {provider = _32_, hl = {fg = "diag_hint"}}, condition = conditions.has_diagnostics, init = _34_, update = {"DiagnosticChanged", "BufEnter", "CursorMoved"}}
local git_component
local function _36_(self)
  return (icontab.github .. self.status_dict.head .. space)
end
local function _37_(self)
  local added = (self.status_dict.added or 0)
  if (added > 0) then
    return (icontab["diff-add"] .. added .. space)
  else
    return nil
  end
end
local function _39_(self)
  local deleted = (self.status_dict.removed or 0)
  if (deleted > 0) then
    return (icontab["diff-removed"] .. deleted .. space)
  else
    return nil
  end
end
local function _41_(self)
  local changed = (self.status_dict.changed or 0)
  if (changed > 0) then
    return (icontab["diff-modified"] .. changed .. space)
  else
    return nil
  end
end
local function _43_(self)
  self.status_dict = vim.b.gitsigns_status_dict
  self.has_changes = ((self.status_dict.added ~= 0) or (self.status_dict.removed ~= 0) or (self.status_dict.changed ~= 0))
  return nil
end
git_component = {{provider = _36_, hl = {bold = true}}, {provider = _37_, hl = {fg = "git_add"}}, {provider = _39_, hl = {fg = "git_del"}}, {provider = _41_, hl = {fg = "git_change"}}, condition = conditions.is_git_repo, flexible = true, init = _43_, hl = {fg = "purple", bg = colors.color2}}
local dap_component
local function _44_()
  local session = dap.session()
  return (session ~= nil)
end
local function _45_()
  return (icontab["play-circle"] .. space .. dap.status())
end
dap_component = {condition = _44_, provider = _45_, hl = {fg = colors.color4}}
local denops_component
local function _46_()
  local _47_ = vim.fn["denops#server#status"]()
  if (_47_ == "running") then
    return (icontab.dinosaur .. space)
  else
    local _ = _47_
    return ""
  end
end
denops_component = {provider = _46_, hl = {fg = colors.color4, bg = colors.color2}}
local skkeleton_component
local function _49_()
  local mode
  do
    local _50_ = vim.fn["skkeleton#mode"]()
    if (_50_ == "hira") then
      mode = "\227\129\130"
    elseif (_50_ == "kata") then
      mode = "\227\130\162"
    elseif (_50_ == "hankata") then
      mode = "\239\189\167\239\189\177"
    elseif (_50_ == "ascii") then
      mode = "aA"
    elseif (_50_ == "zenei") then
      mode = "\239\189\129"
    elseif (_50_ == "abbrev") then
      mode = "a\227\129\130"
    else
      local _ = _50_
      mode = nil
    end
  end
  if mode then
    return (icontab["cursor-text"] .. mode .. space)
  else
    return nil
  end
end
skkeleton_component = {provider = _49_, hl = {fg = colors.color10, bg = colors.color2}}
local spell_component
local function _53_()
  return vim.wo.spell
end
local function _54_()
  return (icontab.spellcheck .. vim.o.spelllang .. space)
end
spell_component = {condition = _53_, provider = _54_, hl = {fg = colors.hint, bg = colors.color2}}
local paste_component
local function _55_()
  return vim.o.paste
end
paste_component = {condition = _55_, provider = (icontab.paste .. space), hl = {fg = colors.hint, bg = colors.color2}}
local search_component
local function _56_()
  return (vim.v.hlsearch ~= 0)
end
local function _57_(self)
  local ok, search = pcall(vim.fn.searchcount)
  local word = vim.fn.getreg("/")
  if (ok and search.total) then
    self.search = search
    self.word = word
    return nil
  else
    return nil
  end
end
local function _59_(self)
  return string.format((icontab.search .. self.word .. "[%d/%d]" .. space), self.search.current, math.min(self.search.total, self.search.maxcount))
end
search_component = {condition = _56_, init = _57_, provider = _59_, hl = {fg = colors.hint, bg = colors.color2}}
local macrorec_component
local function _60_()
  return (vim.fn.reg_recording() ~= "")
end
local function _61_()
  return (icontab.recording .. "[" .. vim.fn.reg_recording() .. "]" .. space)
end
macrorec_component = {condition = _60_, provider = _61_, hl = {fg = colors.info, bg = colors.color2}, update = {"RecordingEnter", "RecordingLeave"}}
local copilot_component
local function _62_()
  return (core.get(package.loaded, "copilot") ~= nil)
end
local function _63_()
  local copilot = require("copilot.client")
  local api = require("copilot.api")
  if (not copilot.buf_is_attached(vim.api.nvim_get_current_buf()) or copilot.is_disabled()) then
    return icontab["copilot-disabled"]
  else
    if (api.status.data.status == "Warning") then
      return icontab["copilot-warning"]
    else
      if vim.b.copilot_suggestion_auto_trigger then
        return icontab["copilot-sleep"]
      else
        return icontab["copilot-enabled"]
      end
    end
  end
end
copilot_component = {condition = _62_, provider = _63_, hl = {fg = colors.hint, bg = colors.color2}}
local default_statusline = {vi_mode_component, space_component, filename_block, align_component, search_component, macrorec_component, align_component, git_component, skkeleton_component, denops_component, spell_component, paste_component, ruler_component, scrollbar_component}
local standard_winbar = {cwd_component, align_component, dap_component, align_component, copilot_component, diagnostics_component, lsp_component}
local function _67_(args)
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix", "^terminal$"}, filetype = {"^git.*", "Trouble", "^dap-repl$", "^dapui_watches$", "^dapui_stacks$", "^dapui_breakpoints$", "^dapui_scopes$", "^NvimTree$"}})
end
return heirline.setup({statusline = {default_statusline}, winbar = {standard_winbar}, opts = {colors = palette, disable_winbar_cb = _67_}})
