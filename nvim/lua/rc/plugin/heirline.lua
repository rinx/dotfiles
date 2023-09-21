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
      return vim.fn.pathshorten(filename)
    else
      return filename
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
file_flags_component = {{condition = _12_, provider = icontab.circle, hl = {fg = colors.hint, bg = colors.color2}}, {condition = _13_, provider = icontab.lock, hl = {fg = colors.hint, bg = colors.color2}}}
local filename_block
local function _14_(self)
  self.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
filename_block = {file_icon_component, space_component, filename_component, file_flags_component, init = _14_}
local ruler_component = {provider = "[%l/%L] ", hl = {fg = colors.hint, bg = colors.color2}}
local scrollbar_component
local function _15_(self)
  local curr_line = core.get(vim.api.nvim_win_get_cursor(0), 1)
  local lines = vim.api.nvim_buf_line_count(0)
  local i = core.inc(math.floor(((core.dec(curr_line) / lines) * core.count(self.sbar))))
  return string.rep(core.get(self.sbar, i), 2)
end
scrollbar_component = {static = {sbar = {"\240\159\173\182", "\240\159\173\183", "\240\159\173\184", "\240\159\173\185", "\240\159\173\186", "\240\159\173\187"}}, provider = _15_, hl = {fg = colors.hint, bg = colors.color2}}
local lsp_component
local function _16_()
  local names = {}
  for _, server in pairs(vim.lsp.get_active_clients({bufnr = 0})) do
    table.insert(names, server.name)
  end
  return (icontab.compas .. table.concat(names, space))
end
lsp_component = {condition = conditions.lsp_attached, update = {"LspAttach", "LspDetach"}, provider = _16_, hl = {fg = colors.info}}
local navic_component
local function _17_()
  return navic.is_available()
end
local function _18_()
  return navic.get_location({highlight = true})
end
navic_component = {condition = _17_, provider = _18_, update = "CursorMoved"}
local diagnostics_component
local function _19_(self)
  if (self.errors > 0) then
    return (icontab.bug .. self.errors .. space)
  else
    return nil
  end
end
local function _21_(self)
  if (self.warns > 0) then
    return (icontab["exclam-circle"] .. self.warns .. space)
  else
    return nil
  end
end
local function _23_(self)
  if (self.infos > 0) then
    return (icontab["info-circle"] .. self.infos .. space)
  else
    return nil
  end
end
local function _25_(self)
  if (self.hints > 0) then
    return (icontab.leaf .. self.hints .. space)
  else
    return nil
  end
end
local function _27_(self)
  local dc
  local function _28_(severity)
    return core.count(vim.diagnostic.get(0, {severity = severity}))
  end
  dc = _28_
  self.errors = dc(vim.diagnostic.severity.ERROR)
  self.warns = dc(vim.diagnostic.severity.WARN)
  self.infos = dc(vim.diagnostic.severity.INFO)
  self.hints = dc(vim.diagnostic.severity.HINT)
  return nil
end
diagnostics_component = {{provider = _19_, hl = {fg = "diag_error"}}, {provider = _21_, hl = {fg = "diag_warn"}}, {provider = _23_, hl = {fg = "diag_info"}}, {provider = _25_, hl = {fg = "diag_hint"}}, condition = conditions.has_diagnostics, init = _27_, update = {"DiagnosticChanged", "BufEnter", "CursorMoved"}}
local git_component
local function _29_(self)
  return (icontab.github .. self.status_dict.head .. space)
end
local function _30_(self)
  local added = (self.status_dict.added or 0)
  if (added > 0) then
    return (icontab["diff-add"] .. added .. space)
  else
    return nil
  end
end
local function _32_(self)
  local deleted = (self.status_dict.removed or 0)
  if (deleted > 0) then
    return (icontab["diff-removed"] .. deleted .. space)
  else
    return nil
  end
end
local function _34_(self)
  local changed = (self.status_dict.changed or 0)
  if (changed > 0) then
    return (icontab["diff-modified"] .. changed .. space)
  else
    return nil
  end
end
local function _36_(self)
  self.status_dict = vim.b.gitsigns_status_dict
  self.has_changes = ((self.status_dict.added ~= 0) or (self.status_dict.removed ~= 0) or (self.status_dict.changed ~= 0))
  return nil
end
git_component = {{provider = _29_, hl = {bold = true}}, {provider = _30_, hl = {fg = "git_add"}}, {provider = _32_, hl = {fg = "git_del"}}, {provider = _34_, hl = {fg = "git_change"}}, condition = conditions.is_git_repo, init = _36_, hl = {fg = "purple", bg = colors.color2}}
local dap_component
local function _37_()
  local session = dap.session()
  return (session ~= nil)
end
local function _38_()
  return (icontab["play-circle"] .. space .. dap.status())
end
dap_component = {condition = _37_, provider = _38_, hl = {fg = colors.color4}}
local denops_component
local function _39_()
  local _40_ = vim.fn["denops#server#status"]()
  if (_40_ == "running") then
    return (icontab.dinosaur .. space)
  elseif true then
    local _ = _40_
    return ""
  else
    return nil
  end
end
denops_component = {provider = _39_, hl = {fg = colors.color4, bg = colors.color2}}
local skkeleton_component
local function _42_()
  local mode
  do
    local _43_ = vim.fn["skkeleton#mode"]()
    if (_43_ == "hira") then
      mode = "\227\129\130"
    elseif (_43_ == "kata") then
      mode = "\227\130\162"
    elseif (_43_ == "hankata") then
      mode = "\239\189\167\239\189\177"
    elseif (_43_ == "ascii") then
      mode = "aA"
    elseif (_43_ == "zenei") then
      mode = "\239\189\129"
    elseif (_43_ == "abbrev") then
      mode = "a\227\129\130"
    elseif true then
      local _ = _43_
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
skkeleton_component = {provider = _42_, hl = {fg = colors.color10, bg = colors.color2}}
local ghosttext_component
local function _46_()
  if vim.g.ghosttext_started then
    return (icontab.ghost .. space)
  else
    local _47_ = vim.fn["ghosttext#status"]()
    if (_47_ == "running") then
      vim.g.ghosttext_started = true
      return (icontab.ghost .. space)
    elseif true then
      local _ = _47_
      return ""
    else
      return nil
    end
  end
end
ghosttext_component = {provider = _46_, hl = {fg = colors.color4, bg = colors.color2}}
local spell_component
local function _50_()
  return vim.wo.spell
end
local function _51_()
  return (icontab.spellcheck .. vim.o.spelllang .. space)
end
spell_component = {condition = _50_, provider = _51_, hl = {fg = colors.hint, bg = colors.color2}}
local paste_component
local function _52_()
  return vim.o.paste
end
paste_component = {condition = _52_, provider = (icontab.paste .. space), hl = {fg = colors.hint, bg = colors.color2}}
local default_statusline = {vi_mode_component, space_component, filename_block, align_component, git_component, skkeleton_component, denops_component, ghosttext_component, spell_component, paste_component, ruler_component, scrollbar_component}
local lsp_winbar = {navic_component, align_component, dap_component, align_component, diagnostics_component, lsp_component}
local function _53_(args)
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix", "^terminal$"}, filetype = {"^git.*", "Trouble", "^dap-repl$", "^dapui_watches$", "^dapui_stacks$", "^dapui_breakpoints$", "^dapui_scopes$", "^NvimTree$"}})
end
return heirline.setup({statusline = {default_statusline}, winbar = {lsp_winbar}, opts = {colors = palette, disable_winbar_cb = _53_}})
