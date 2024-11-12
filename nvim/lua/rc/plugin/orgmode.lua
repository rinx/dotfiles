-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local icon = autoload("rc.icon")
local icontab = icon.tab
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
orgmode.setup({org_agenda_files = {inbox, __3epath("journal/*.org"), __3epath("notes/**/*.org")}, org_default_notes_file = inbox, org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "WAITING", "IN_REVIEW", "|", "CANCELED", "DONE"}, org_startup_folded = "overview", org_capture_templates = {t = {description = "Add a new task to inbox", template = __3etmplstr("task.org"), target = inbox, headline = "Tasks"}, n = {description = "Add a new note to inbox", subtemplates = {c = {description = "code-reading note", template = __3etmplstr("code-note.org"), target = inbox, headline = "Notes"}, d = {description = "default note", template = __3etmplstr("note.org"), target = inbox, headline = "Notes"}, l = {description = "with link", template = __3etmplstr("link.org"), target = inbox, headline = "Notes"}, p = {description = "with clipboard content", template = __3etmplstr("paste.org"), target = inbox, headline = "Notes"}}}, i = {description = "Add a new idea", template = __3etmplstr("idea.org"), target = inbox, headline = "Ideas"}, s = {description = "Add a new topic", template = __3etmplstr("topic.org"), target = inbox, headline = "Topics"}, j = {description = "Add a new note to journal", template = __3etmplstr("journal.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}}, org_tags_column = 90, org_id_link_to_org_use_id = true, org_custom_exports = {g = {label = "Export to GitHub flavored markdown", action = _4_}}, win_split_mode = "auto", ui = {menu = {handler = _5_}}})
roam.setup({directory = __3epath("roam"), org_files = {inbox, __3epath("journal/*.org")}, templates = {f = {description = "fleeting", template = __3etmplstr("roam/fleeting.org"), target = "fleeting%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, w = {description = "wiki", template = __3etmplstr("roam/wiki.org"), target = "wiki%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, p = {description = "project", template = __3etmplstr("roam/project.org"), target = "project%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, c = {description = "code", template = __3etmplstr("roam/code.org"), target = "code%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, b = {description = "book", template = __3etmplstr("roam/book.org"), target = "book%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, s = {description = "scrap", template = __3etmplstr("roam/scrap.org"), target = "scrap/%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}}})
bullets.setup({symbols = icon["org-bullets"], concealcursor = false})
local function open_fn(filepath)
  local function _6_()
    return vim.cmd(("e " .. filepath))
  end
  return _6_
end
do
  local filepath = __3epath("inbox.org")
  vim.api.nvim_create_user_command("OrgInbox", open_fn(filepath), {})
end
do
  local filepath = __3epath(("journal/" .. vim.fn.strftime("%Y-%m", vim.fn.localtime()) .. ".org"))
  vim.api.nvim_create_user_command("OrgJournal", open_fn(filepath), {})
end
local function live_grep_fn(path)
  local function _7_()
    local tb = require("telescope.builtin")
    return tb.live_grep({cwd = path, type_filter = "org"})
  end
  return _7_
end
vim.api.nvim_create_user_command("OrgLiveGrep", live_grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamLiveGrep", live_grep_fn(__3epath("roam")), {})
local function grep_fn(path)
  local function _8_()
    local query = vim.fn.input("Grep: ")
    local tb = require("telescope.builtin")
    if (query and not (query == "")) then
      return tb.grep_string({prompt_title = ("Grep for: " .. query), cwd = path, use_regex = true, search = vim.fn["kensaku#query"](query, {rxop = vim.g["kensaku#rxop#javascript"]})})
    else
      return nil
    end
  end
  return _8_
end
vim.api.nvim_create_user_command("OrgGrep", grep_fn(basepath), {})
return vim.api.nvim_create_user_command("RoamGrep", grep_fn(__3epath("roam")), {})
