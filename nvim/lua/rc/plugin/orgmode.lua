-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local orgmode = require("orgmode")
local bullets = require("org-bullets")
local modern_menu = require("org-modern.menu")
local basepath = vim.fn.expand("~/notes/org")
local templates
do
  local info = debug.getinfo(1)
  templates = vim.fn.expand((vim.fn.fnamemodify(info.source:sub(2), ":h") .. "/../../../orgmode/templates"))
end
local function __3epath(path)
  return (basepath .. "/" .. path)
end
local function __3etmpl(path)
  return (templates .. "/" .. path)
end
local function __3etmplstr(path)
  return vim.fn.join(vim.fn.readfile(__3etmpl(path)), "\n")
end
local inbox = __3epath("inbox.org")
if not (vim.fn.isdirectory(basepath) == 1) then
  vim.fn.mkdir(basepath, "p")
else
end
if not (vim.fn.filereadable(inbox) == 1) then
  vim.fn.writefile(vim.fn.readfile(__3etmpl("inbox.org")), inbox)
else
end
local function _4_(data)
  local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
  return m:open(data)
end
orgmode.setup({org_agenda_files = {inbox, __3epath("journal/*.org")}, org_default_notes_file = inbox, org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "WAITING", "|", "CANCELED", "DONE"}, org_startup_folded = "showeverything", org_capture_templates = {t = {description = "Add a new task to inbox", template = __3etmplstr("task.org"), headline = "Tasks"}, c = {description = "Add a code-reading note to inbox", template = __3etmplstr("code-note.org"), headline = "Notes"}, n = {description = "Add a new note to inbox", template = __3etmplstr("note.org"), headline = "Notes"}, l = {description = "Add a new note to inbox with link", template = __3etmplstr("link.org"), headline = "Notes"}, p = {description = "Add a new note to inbox with clipboard content", template = __3etmplstr("paste.org"), headline = "Notes"}, j = {description = "Add a new note to journal", template = __3etmplstr("journal.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}}, org_tags_column = 90, win_split_mode = "auto", ui = {menu = {handler = _4_}}})
return bullets.setup({symbols = {list = "\226\128\162", headlines = {"\226\151\137", "\226\151\139", "\226\156\184", "\226\156\191"}}, concealcursor = false})
