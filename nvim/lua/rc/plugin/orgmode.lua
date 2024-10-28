-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local orgmode = require("orgmode")
local bullets = require("org-bullets")
local modern_menu = require("org-modern.menu")
local basepath = "~/notes/org"
local function __3epath(path)
  return (basepath .. "/" .. path)
end
local function _1_(data)
  local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
  return m:open(data)
end
orgmode.setup({org_agenda_files = __3epath("agenda/**/*"), org_default_notes_file = __3epath("inbox.org"), org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "WAITING", "|", "CANCELED", "DONE"}, org_startup_folded = "showeverything", org_capture_templates = {t = {description = "Add a new task to inbox", template = "** TODO %?\n %U", headline = "Tasks"}, c = {description = "Add a code-reading note to inbox", template = "** %?\n %a %U", headline = "Codes"}, j = {description = "Add a new event or thoughts to journal", template = "\n* %<%Y-%m-%d> %<%A>\n** %U\n\n%?", target = __3epath("journal/%<%Y-%m>.org")}}, org_tags_column = 90, win_split_mode = "auto", ui = {menu = {handler = _1_}}})
return bullets.setup({symbols = {list = "\226\128\162", headlines = {"\226\151\137", "\226\151\139", "\226\156\184", "\226\156\191"}}, concealcursor = false})
