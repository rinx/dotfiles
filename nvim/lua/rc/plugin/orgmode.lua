-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local orgmode = require("orgmode")
local bullets = require("org-bullets")
local modern_menu = require("org-modern.menu")
do
  local basepath = "~/notes/org"
  local __3epath
  local function _1_(path)
    return (basepath .. "/" .. path)
  end
  __3epath = _1_
  local function _2_(data)
    local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
    return m:open(data)
  end
  orgmode.setup({org_agenda_files = __3epath("agenda/**/*"), org_default_notes_file = __3epath("refile.org"), org_archive_location = __3epath("archive/%s_archive::"), win_split_mode = "auto", ui = {menu = {handler = _2_}}})
end
return bullets.setup({symbols = {list = "\226\128\162", headlines = {"\226\151\137", "\226\151\139", "\226\156\184", "\226\156\191"}}, concealcursor = false})
