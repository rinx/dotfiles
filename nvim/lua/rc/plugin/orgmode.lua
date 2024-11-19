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
  local cmd = {"pandoc", current, "--from=org", "--to=gfm", "-o", target}
  local on_success
  local function _5_(output)
    return vim.notify(("Wrote to " .. target))
  end
  on_success = _5_
  local on_error
  local function _6_(err)
    return vim.notify(("Error: " .. err))
  end
  on_error = _6_
  return exporter(cmd, target, on_success, on_error)
end
local function _7_(exporter)
  local org_api = require("orgmode.api")
  local current = org_api.current()
  local headline = current:get_closest_headline()
  local lines = vim.api.nvim_buf_get_lines(0, (headline.position.start_line - 1), headline.position.end_line, false)
  local content = table.concat(lines, "\n")
  local tmppath = vim.fn.tempname()
  local tmp = io.open(tmppath, "w")
  local cmd = {"pandoc", tmppath, "--from=org", "--to=gfm"}
  local on_success
  local function _8_(output)
    vim.fn.setreg("+", output)
    return vim.notify("Successfully copied into clipboard")
  end
  on_success = _8_
  local on_error
  local function _9_(err)
    return vim.notify(("Error: " .. err))
  end
  on_error = _9_
  tmp:write(content)
  tmp:close()
  return exporter(cmd, "", on_success, on_error)
end
local function _10_(exporter)
  local export_type = vim.fn.input("Export type: ")
  if (export_type and not (export_type == "")) then
    local org_api = require("orgmode.api")
    local current = org_api.current()
    local headline = current:get_closest_headline()
    local lines = vim.api.nvim_buf_get_lines(0, (headline.position.start_line - 1), headline.position.end_line, false)
    local content = table.concat(lines, "\n")
    local tmppath = vim.fn.tempname()
    local tmp = io.open(tmppath, "w")
    local cmd = {"pandoc", tmppath, "--from=org", ("--to=" .. export_type)}
    local on_success
    local function _11_(output)
      vim.fn.setreg("+", output)
      return vim.notify("Successfully copied into clipboard")
    end
    on_success = _11_
    local on_error
    local function _12_(err)
      return vim.notify(("Error: " .. err))
    end
    on_error = _12_
    tmp:write(content)
    tmp:close()
    return exporter(cmd, "", on_success, on_error)
  else
    return nil
  end
end
local function _14_(data)
  local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
  return m:open(data)
end
orgmode.setup({org_agenda_files = {inbox, __3epath("journal/*.org"), __3epath("notes/**/*.org")}, org_default_notes_file = inbox, org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "WAITING", "IN_REVIEW", "|", "CANCELED", "DONE"}, org_startup_folded = "overview", org_capture_templates = {t = {description = "\239\128\140 Add a new task to inbox", template = __3etmplstr("task.org"), target = inbox, headline = "Tasks"}, n = {description = "\239\137\137 Add a new note to inbox", subtemplates = {c = {description = "\243\176\133\180 code-reading note", template = __3etmplstr("code-note.org"), target = inbox, headline = "Notes"}, d = {description = "\239\137\137 default note", template = __3etmplstr("note.org"), target = inbox, headline = "Notes"}, l = {description = "\239\145\140 with link", template = __3etmplstr("link.org"), target = inbox, headline = "Notes"}, p = {description = "\239\129\191 with clipboard content", template = __3etmplstr("paste.org"), target = inbox, headline = "Notes"}}}, i = {description = "\239\144\128 Add a new idea", template = __3etmplstr("idea.org"), target = inbox, headline = "Ideas"}, s = {description = "\239\128\133 Add a new topic", template = __3etmplstr("topic.org"), target = inbox, headline = "Topics"}, j = {description = "\243\176\131\173 Add a new note to journal", template = __3etmplstr("journal.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}}, org_tags_column = 90, org_id_link_to_org_use_id = true, org_custom_exports = {g = {label = "Export to GitHub flavored markdown", action = _4_}, c = {label = "Export closest headline to clipboard as GitHub flavored markdown", action = _7_}, x = {label = "Export closest headline to clipboard", action = _10_}}, win_split_mode = "auto", ui = {menu = {handler = _14_}}})
roam.setup({directory = __3epath("roam"), org_files = {inbox, __3epath("journal/*.org")}, templates = {f = {description = "\243\176\142\154 fleeting", template = __3etmplstr("roam/fleeting.org"), target = "fleeting%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, w = {description = "\243\176\150\172 wiki", template = __3etmplstr("roam/wiki.org"), target = "wiki%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, p = {description = "\239\148\131 project", template = __3etmplstr("roam/project.org"), target = "project%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, c = {description = "\239\132\161 code", template = __3etmplstr("roam/code.org"), target = "code%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, b = {description = "\239\144\133 book", template = __3etmplstr("roam/book.org"), target = "book%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, s = {description = "\239\132\174 scrap", template = __3etmplstr("roam/scrap.org"), target = "scrap/%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}}})
bullets.setup({symbols = icon["org-bullets"], concealcursor = false})
local function open_fn(filepath)
  local function _15_()
    return vim.cmd(("e " .. filepath))
  end
  return _15_
end
do
  local filepath = __3epath("inbox.org")
  vim.api.nvim_create_user_command("OrgInbox", open_fn(filepath), {})
end
do
  local filepath = __3epath(("journal/" .. vim.fn.strftime("%Y-%m", vim.fn.localtime()) .. ".org"))
  vim.api.nvim_create_user_command("OrgJournal", open_fn(filepath), {})
end
local function fd_fn()
  local tb = require("telescope.builtin")
  return tb.find_files({cwd = basepath, no_ignore = true, no_ignore_parent = true})
end
vim.api.nvim_create_user_command("OrgFind", fd_fn, {})
local function live_grep_fn(path)
  local function _16_()
    local tb = require("telescope.builtin")
    return tb.live_grep({cwd = path, type_filter = "org"})
  end
  return _16_
end
vim.api.nvim_create_user_command("OrgLiveGrep", live_grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamLiveGrep", live_grep_fn(__3epath("roam")), {})
local function grep_fn(path)
  local function _17_()
    local query = vim.fn.input("Grep: ")
    local tb = require("telescope.builtin")
    if (query and not (query == "")) then
      return tb.grep_string({prompt_title = ("Grep for: " .. query), cwd = path, use_regex = true, search = vim.fn["kensaku#query"](query, {rxop = vim.g["kensaku#rxop#javascript"]})})
    else
      return nil
    end
  end
  return _17_
end
vim.api.nvim_create_user_command("OrgGrep", grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamGrep", grep_fn(__3epath("roam")), {})
local function refile_to_today()
  local date = os.date("%Y-%m-%d")
  return vim.cmd(("Telescope orgmode refile_heading default_text=" .. date))
end
return vim.api.nvim_create_user_command("OrgRefileToToday", refile_to_today, {})
