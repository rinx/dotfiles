-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local icon = autoload("rc.icon")
local orgmode = require("orgmode")
local roam = require("org-roam")
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
local function _4_(exporter)
  local current = vim.api.nvim_buf_get_name(0)
  local target = (vim.fn.fnamemodify(current, ":p:r") .. ".md")
  local cmd = {"pandoc", current, "-o", target}
  return exporter(cmd, target)
end
local function _5_(data)
  local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
  return m:open(data)
end
orgmode.setup({org_agenda_files = {inbox, __3epath("journal/*.org")}, org_default_notes_file = inbox, org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "WAITING", "IN_REVIEW", "|", "CANCELED", "DONE"}, org_startup_folded = "overview", org_capture_templates = {t = {description = "Add a new task to inbox", template = __3etmplstr("task.org"), target = inbox, headline = "Tasks"}, n = {description = "Add a new note to inbox", subtemplates = {c = {description = "code-reading note", template = __3etmplstr("code-note.org"), target = inbox, headline = "Notes"}, d = {description = "default note", template = __3etmplstr("note.org"), target = inbox, headline = "Notes"}, l = {description = "with link", template = __3etmplstr("link.org"), target = inbox, headline = "Notes"}, p = {description = "with clipboard content", template = __3etmplstr("paste.org"), target = inbox, headline = "Notes"}}}, i = {description = "Add a new idea", template = __3etmplstr("idea.org"), target = inbox, headline = "Ideas"}, s = {description = "Add a new topic", template = __3etmplstr("topic.org"), target = inbox, headline = "Topics"}, j = {description = "Add a new note to journal", template = __3etmplstr("journal.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}}, org_tags_column = 90, org_custom_exports = {g = {label = "Export to GitHub flavored markdown", action = _4_}}, win_split_mode = "auto", ui = {menu = {handler = _5_}}})
roam.setup({directory = __3epath("roam"), org_files = {inbox, __3epath("journal/*.org")}})
return bullets.setup({symbols = icon["org-bullets"], concealcursor = false})
