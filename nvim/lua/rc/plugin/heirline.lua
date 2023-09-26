-- [nfnl] Compiled from fnl/rc/plugin/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local heirline = autoload("heirline")
local conditions = autoload("heirline.conditions")
local utils = autoload("heirline.utils")
local devicons = autoload("nvim-web-devicons")
local dap = autoload("dap")
local navic = autoload("nvim-navic")
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
  local m = (self.mode):sub(1, 1)
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
      return vim.fn.pathshorten(filename)
    end
  end
end
filename_component = {provider = _9_, hl = {fg = colors.hint, bg = colors.color2, bold = true}}
local file_flags_component
local function _12_()
  return vim.bo.modified
end
local function _13_()
  return (not vim.bo.modifiable or vim.bo.readonly)
end
file_flags_component = {{condition = _12_, provider = (space .. icontab.circle), hl = {fg = colors.hint, bg = colors.color2}}, {condition = _13_, provider = (space .. icontab.lock), hl = {fg = colors.hint, bg = colors.color2}}}
local filename_block
local function _14_(self)
  self.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
filename_block = {file_icon_component, space_component, filename_component, file_flags_component, init = _14_}
local cwd_component
local function _15_()
  local shorten
  local function _16_(cwd)
    if conditions.width_percent_below(core.count(cwd), 0.25) then
      return cwd
    else
      return vim.fn.pathshorten(cwd)
    end
  end
  shorten = _16_
  local trail
  local function _18_(cwd)
    if (cwd:sub(-1) == "/") then
      return cwd
    else
      return (cwd .. "/")
    end
  end
  trail = _18_
  local cwd = trail(shorten(vim.fn.fnamemodify(vim.fn.getcwd(0), ":~")))
  return (icontab.directory .. space .. cwd .. space)
end
cwd_component = {provider = _15_, hl = {fg = colors.hint}}
local ruler_component = {provider = "[%l/%L] ", hl = {fg = colors.hint, bg = colors.color2}}
local scrollbar_component
local function _20_(self)
  local curr_line = core.get(vim.api.nvim_win_get_cursor(0), 1)
  local lines = vim.api.nvim_buf_line_count(0)
  local i = core.inc(math.floor(((core.dec(curr_line) / lines) * core.count(self.sbar))))
  return string.rep(core.get(self.sbar, i), 2)
end
scrollbar_component = {static = {sbar = {"\240\159\173\182", "\240\159\173\183", "\240\159\173\184", "\240\159\173\185", "\240\159\173\186", "\240\159\173\187"}}, provider = _20_, hl = {fg = colors.hint, bg = colors.color2}}
local lsp_component
local function _21_()
  local clients = core.count(vim.lsp.get_active_clients({bufnr = 0}))
  if (clients >= 2) then
    return (icontab.compas .. clients)
  else
    return icontab.compas
  end
end
local function _23_()
  local function _24_()
    return vim.cmd("LspInfo")
  end
  return vim.defer_fn(_24_, 100)
end
lsp_component = {condition = conditions.lsp_attached, update = {"LspAttach", "LspDetach"}, provider = _21_, on_click = {callback = _23_, name = "heirline_LSP"}, hl = {fg = colors.info}}
local navic_component
local function _25_()
  return navic.is_available()
end
local function _26_()
  return (icontab.slash .. space .. navic.get_location({highlight = true}))
end
navic_component = {condition = _25_, provider = _26_, update = "CursorMoved"}
local diagnostics_component
local function _27_(self)
  if (self.errors > 0) then
    return (icontab.bug .. self.errors .. space)
  else
    return nil
  end
end
local function _29_(self)
  if (self.warns > 0) then
    return (icontab["exclam-circle"] .. self.warns .. space)
  else
    return nil
  end
end
local function _31_(self)
  if (self.infos > 0) then
    return (icontab["info-circle"] .. self.infos .. space)
  else
    return nil
  end
end
local function _33_(self)
  if (self.hints > 0) then
    return (icontab.leaf .. self.hints .. space)
  else
    return nil
  end
end
local function _35_(self)
  local dc
  local function _36_(severity)
    return core.count(vim.diagnostic.get(0, {severity = severity}))
  end
  dc = _36_
  self.errors = dc(vim.diagnostic.severity.ERROR)
  self.warns = dc(vim.diagnostic.severity.WARN)
  self.infos = dc(vim.diagnostic.severity.INFO)
  self.hints = dc(vim.diagnostic.severity.HINT)
  return nil
end
diagnostics_component = {{provider = _27_, hl = {fg = "diag_error"}}, {provider = _29_, hl = {fg = "diag_warn"}}, {provider = _31_, hl = {fg = "diag_info"}}, {provider = _33_, hl = {fg = "diag_hint"}}, condition = conditions.has_diagnostics, init = _35_, update = {"DiagnosticChanged", "BufEnter", "CursorMoved"}}
local git_component
local function _37_(self)
  return (icontab.github .. self.status_dict.head .. space)
end
local function _38_(self)
  local added = (self.status_dict.added or 0)
  if (added > 0) then
    return (icontab["diff-add"] .. added .. space)
  else
    return nil
  end
end
local function _40_(self)
  local deleted = (self.status_dict.removed or 0)
  if (deleted > 0) then
    return (icontab["diff-removed"] .. deleted .. space)
  else
    return nil
  end
end
local function _42_(self)
  local changed = (self.status_dict.changed or 0)
  if (changed > 0) then
    return (icontab["diff-modified"] .. changed .. space)
  else
    return nil
  end
end
local function _44_(self)
  self.status_dict = vim.b.gitsigns_status_dict
  self.has_changes = ((self.status_dict.added ~= 0) or (self.status_dict.removed ~= 0) or (self.status_dict.changed ~= 0))
  return nil
end
git_component = {{provider = _37_, hl = {bold = true}}, {provider = _38_, hl = {fg = "git_add"}}, {provider = _40_, hl = {fg = "git_del"}}, {provider = _42_, hl = {fg = "git_change"}}, condition = conditions.is_git_repo, init = _44_, hl = {fg = "purple", bg = colors.color2}}
local dap_component
local function _45_()
  local session = dap.session()
  return (session ~= nil)
end
local function _46_()
  return (icontab["play-circle"] .. space .. dap.status())
end
dap_component = {condition = _45_, provider = _46_, hl = {fg = colors.color4}}
local denops_component
local function _47_()
  local _48_ = vim.fn["denops#server#status"]()
  if (_48_ == "running") then
    return (icontab.dinosaur .. space)
  elseif true then
    local _ = _48_
    return ""
  else
    return nil
  end
end
denops_component = {provider = _47_, hl = {fg = colors.color4, bg = colors.color2}}
local skkeleton_component
local function _50_()
  local mode
  do
    local _51_ = vim.fn["skkeleton#mode"]()
    if (_51_ == "hira") then
      mode = "\227\129\130"
    elseif (_51_ == "kata") then
      mode = "\227\130\162"
    elseif (_51_ == "hankata") then
      mode = "\239\189\167\239\189\177"
    elseif (_51_ == "ascii") then
      mode = "aA"
    elseif (_51_ == "zenei") then
      mode = "\239\189\129"
    elseif (_51_ == "abbrev") then
      mode = "a\227\129\130"
    elseif true then
      local _ = _51_
      mode = nil
    else
      mode = nil
    end
  end
  if mode then
    return (icontab["cursor-text"] .. mode .. space)
  else
    return nil
  end
end
skkeleton_component = {provider = _50_, hl = {fg = colors.color10, bg = colors.color2}}
local ghosttext_component
local function _54_()
  if vim.g.ghosttext_started then
    return (icontab.ghost .. space)
  else
    local _55_ = vim.fn["ghosttext#status"]()
    if (_55_ == "running") then
      vim.g.ghosttext_started = true
      return (icontab.ghost .. space)
    elseif true then
      local _ = _55_
      return ""
    else
      return nil
    end
  end
end
ghosttext_component = {provider = _54_, hl = {fg = colors.color4, bg = colors.color2}}
local spell_component
local function _58_()
  return vim.wo.spell
end
local function _59_()
  return (icontab.spellcheck .. vim.o.spelllang .. space)
end
spell_component = {condition = _58_, provider = _59_, hl = {fg = colors.hint, bg = colors.color2}}
local paste_component
local function _60_()
  return vim.o.paste
end
paste_component = {condition = _60_, provider = (icontab.paste .. space), hl = {fg = colors.hint, bg = colors.color2}}
local search_component
local function _61_()
  return (vim.v.hlsearch ~= 0)
end
local function _62_(self)
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
local function _64_(self)
  return string.format((icontab.search .. self.word .. "[%d/%d]" .. space), self.search.current, math.min(self.search.total, self.search.maxcount))
end
search_component = {condition = _61_, init = _62_, provider = _64_, hl = {fg = colors.hint, bg = colors.color2}}
local macrorec_component
local function _65_()
  return (vim.fn.reg_recording() ~= "")
end
local function _66_()
  return (icontab.recording .. "[" .. vim.fn.reg_recording() .. "]" .. space)
end
macrorec_component = {condition = _65_, provider = _66_, hl = {fg = colors.info, bg = colors.color2}, update = {"RecordingEnter", "RecordingLeave"}}
local default_statusline = {vi_mode_component, space_component, filename_block, align_component, search_component, macrorec_component, align_component, git_component, skkeleton_component, denops_component, ghosttext_component, spell_component, paste_component, ruler_component, scrollbar_component}
local standard_winbar = {cwd_component, navic_component, align_component, dap_component, align_component, diagnostics_component, lsp_component}
local function _67_(args)
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix", "^terminal$"}, filetype = {"^git.*", "Trouble", "^dap-repl$", "^dapui_watches$", "^dapui_stacks$", "^dapui_breakpoints$", "^dapui_scopes$", "^NvimTree$"}})
end
return heirline.setup({statusline = {default_statusline}, winbar = {standard_winbar}, opts = {colors = palette, disable_winbar_cb = _67_}})
