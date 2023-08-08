-- [nfnl] Compiled from fnl/rc/plugin/feline.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local feline = require("feline")
local vimode_providers = require("feline.providers.vi_mode")
local lsp_providers = require("feline.providers.lsp")
local color = autoload("rc.color")
local icon = autoload("rc.icon")
local colors = color.colors
local icontab = icon.tab
local space = " "
local fill = "\226\150\138"
local vi_mode_colors = {NORMAL = colors.info, INSERT = colors.error, VISUAL = colors.color8, OP = colors.info, BLOCK = colors.hint, REPLACE = colors.purple, [{"V-REPLACE"}] = colors.purple, ENTER = colors.color10, MORE = colors.color10, SELECT = colors.warn, COMMAND = colors.info, SHELL = colors.info, TERM = colors.info, NONE = colors.color3}
local lsp_icons = {error = icontab.bug, warn = icontab["exclam-circle"], info = icontab["info-circle"], hint = icontab.leaf}
local function vimode_hl()
  return {name = vimode_providers.get_mode_highlight_name(), fg = vimode_providers.get_mode_color()}
end
local function lsp_diagnostics_info()
  return {error = lsp_providers.get_diagnostics_count("Error"), warn = lsp_providers.get_diagnostics_count("Warn"), info = lsp_providers.get_diagnostics_count("Info"), hint = lsp_providers.get_diagnostics_count("Hint")}
end
local function diagnostics_enable(f, s)
  local function _2_()
    local diag = core.get(f(), s)
    return (diag and (diag ~= 0))
  end
  return _2_
end
local function diagnostics_of(f, s)
  local function _3_()
    local diag = core.get(f(), s)
    local ic = core.get(lsp_icons, s)
    return (ic .. diag)
  end
  return _3_
end
local function nc(...)
  local str = ""
  for _, v in ipairs({...}) do
    if v then
      str = (str .. v)
    else
      str = str
    end
  end
  return str
end
local comps
local function _5_()
  return vim.o.paste
end
local function _6_()
  return vim.wo.spell
end
local function _7_()
  return vim.fn["skkeleton#is_enabled"]()
end
comps = {vimode = {provider = fill, hl = vimode_hl, right_sep = space}, paste = {provider = icontab.paste, enabled = _5_, left_sep = space, hl = {fg = colors.hint}}, spell = {provider = (icontab.spellcheck .. vim.o.spelllang), enabled = _6_, left_sep = space, hl = {fg = colors.hint}}, file = {info = {provider = "file_info", hl = {fg = colors.hint, style = "bold"}}, encoding = {provider = "file_encoding", left_sep = space, hl = {fg = colors.purple, style = "bold"}}, type = {provider = "file_type", left_sep = space, hl = {fg = colors.hint, style = "bold"}}}, scrollbar = {provider = "scroll_bar", left_sep = space, hl = {fg = colors.hint, style = "bold"}}, diagnostics = {error = {provider = diagnostics_of(lsp_diagnostics_info, "error"), left_sep = space, enabled = diagnostics_enable(lsp_diagnostics_info, "error"), hl = {fg = colors.error}}, warn = {provider = diagnostics_of(lsp_diagnostics_info, "warn"), left_sep = space, enabled = diagnostics_enable(lsp_diagnostics_info, "warn"), hl = {fg = colors.warn}}, info = {provider = diagnostics_of(lsp_diagnostics_info, "info"), left_sep = space, enabled = diagnostics_enable(lsp_diagnostics_info, "info"), hl = {fg = colors.info}}, hint = {provider = diagnostics_of(lsp_diagnostics_info, "hint"), left_sep = space, enabled = diagnostics_enable(lsp_diagnostics_info, "hint"), hl = {fg = colors.hint}}}, lsp = {provider = "lsp_client_names", left_sep = space, icon = icontab.server, hl = {fg = colors.color13}}, dap = {provider = "dap_status", left_sep = space, hl = {fg = colors.color4}, icon = icontab["play-circle"]}, denops = {provider = "denops_status", left_sep = space}, skkeleton = {provider = "skkeleton_status", enabled = _7_, left_sep = space, hl = {fg = colors.color10}, icon = icontab["cursor-text"]}, ghosttext = {provider = "ghosttext_status", left_sep = space}, devenv = {provider = "devenv_status", left_sep = space}, git = {branch = {provider = "git_branch", icon = icontab.github, left_sep = space, hl = {fg = colors.purple, style = "bold"}}, add = {provider = "git_diff_added", hl = {fg = colors.info}, icon = icontab["diff-add"], left_sep = space}, change = {provider = "git_diff_changed", hl = {fg = colors.warn}, icon = icontab["diff-modified"], left_sep = space}, remove = {provider = "git_diff_removed", hl = {fg = colors.error}, icon = icontab["diff-removed"], left_sep = space}}}
local force_inactive = {filetypes = {"^Trouble$", "^qf$", "^help$", "^dap-repl$", "^dapui_watches$", "^dapui_stacks$", "^dapui_breakpoints$", "^dapui_scopes$", "^packer$", "^NvimTree$", "^SidebarNvim$"}, buftypes = {"^terminal$"}, bufnames = {}}
local components = {active = {{comps.vimode, comps.file.info, comps.lsp, comps.diagnostics.error, comps.diagnostics.warn, comps.diagnostics.info, comps.diagnostics.hint}, {comps.dap, comps.skkeleton}, {comps.git.add, comps.git.change, comps.git.remove, comps.git.branch, comps.file.encoding, comps.devenv, comps.denops, comps.ghosttext, comps.paste, comps.spell, comps.scrollbar}}, inactive = {{comps.file.info}, {}, {}}}
local providers
local function _8_()
  local dap = require("dap")
  return (dap.status() or "")
end
local function _9_()
  local _10_ = vim.fn["denops#server#status"]()
  if (_10_ == "running") then
    return icontab.dinosaur
  elseif true then
    local _ = _10_
    return ""
  else
    return nil
  end
end
local function _12_()
  if not (vim.NIL == vim.fn.getenv("DOCKERIZED_DEVENV")) then
    return icontab.whale
  else
    return ""
  end
end
local function _14_()
  local _15_ = vim.fn["skkeleton#mode"]()
  if (_15_ == "hira") then
    return "\227\129\130"
  elseif (_15_ == "kata") then
    return "\227\130\162"
  elseif (_15_ == "hankata") then
    return "\239\189\167\239\189\177"
  elseif (_15_ == "ascii") then
    return "aA"
  elseif (_15_ == "zenei") then
    return "\239\189\129"
  elseif (_15_ == "abbrev") then
    return "a\227\129\130"
  elseif true then
    local _ = _15_
    return ""
  else
    return nil
  end
end
local function _17_()
  if vim.g.ghosttext_started then
    return icontab.ghost
  else
    local _18_ = vim.fn["ghosttext#status"]()
    if (_18_ == "running") then
      vim.g.ghosttext_started = true
      return icontab.ghost
    elseif true then
      local _ = _18_
      return ""
    else
      return nil
    end
  end
end
providers = {dap_status = _8_, denops_status = _9_, devenv_status = _12_, skkeleton_status = _14_, ghosttext_status = _17_}
vim.o.termguicolors = true
return feline.setup({default_bg = colors.color2, default_fg = colors.color4, components = components, custom_providers = providers, vi_mode_colors = vi_mode_colors, force_inactive = force_inactive})
