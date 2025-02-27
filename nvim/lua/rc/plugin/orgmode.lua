-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local icon = autoload("rc.icon")
local color = autoload("rc.color")
local icontab = icon.tab
local colors = color.colors
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
  local export_type = vim.fn.input("Export type: ")
  if (export_type and not (export_type == "")) then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local content = table.concat(lines, "\n")
    local tmppath = vim.fn.tempname()
    local tmp = io.open(tmppath, "w")
    local cmd = {"pandoc", tmppath, "--from=org", ("--to=" .. export_type)}
    local on_success
    local function _5_(output)
      vim.fn.setreg("+", output)
      return vim.notify("Successfully copied into clipboard")
    end
    on_success = _5_
    local on_error
    local function _6_(err)
      return vim.notify(("Error: " .. err))
    end
    on_error = _6_
    tmp:write(content)
    tmp:close()
    return exporter(cmd, "", on_success, on_error)
  else
    return nil
  end
end
local function _8_(exporter)
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
    local function _9_(output)
      vim.fn.setreg("+", output)
      return vim.notify("Successfully copied into clipboard")
    end
    on_success = _9_
    local on_error
    local function _10_(err)
      return vim.notify(("Error: " .. err))
    end
    on_error = _10_
    tmp:write(content)
    tmp:close()
    return exporter(cmd, "", on_success, on_error)
  else
    return nil
  end
end
local function _12_(exporter)
  local current = vim.api.nvim_buf_get_name(0)
  local target = (vim.fn.fnamemodify(current, ":p:r") .. ".pdf")
  local cmd = {"pandoc", current, "--from=org", "--to=pdf", "--pdf-engine=xelatex", "-V", "documentclass=bxjsarticle", "-V", "classoption=pandoc", "-o", target}
  local on_success
  local function _13_(output)
    return vim.notify(("Successfully saved to: " .. target))
  end
  on_success = _13_
  local on_error
  local function _14_(err)
    return vim.notify(("Error: " .. err))
  end
  on_error = _14_
  return exporter(cmd, target, on_success, on_error)
end
local function _15_(tasks)
  for _, task in ipairs(tasks) do
    local id = string.format("%s:%s", task.original_time:to_string(), task.title)
    local function _16_()
      if task.todo then
        return string.format("%s %s", task.todo, task.title)
      else
        return task.title
      end
    end
    Snacks.notifier(table.concat({string.format("# %s (%s)", task.category, task.humanized_duration), string.format("%s %s", string.rep("*", task.level), _16_()), string.format("%s: <%s>", task.type, task.time:to_string())}, "\n"), "info", {id = id, timeout = false})
  end
  return nil
end
local function _17_(data)
  local m = modern_menu:new({window = {margin = {1, 0, 1, 0}, padding = {0, 1, 0, 1}, title_pos = "center", border = "single", zindex = 1000}, icons = {separator = "\226\158\156"}})
  return m:open(data)
end
orgmode.setup({org_agenda_files = {inbox, __3epath("journal/*.org"), __3epath("notes/**/*.org")}, org_default_notes_file = inbox, org_archive_location = __3epath("archive/%s_archive::"), org_todo_keywords = {"TODO", "PENDING", "IN_REVIEW", "|", "DONE", "CANCELED"}, org_todo_keyword_faces = {TODO = (":foreground " .. colors.color5 .. " :background " .. colors.color8 .. " :underline on"), WAITING = (":foreground " .. colors.color5 .. " :background " .. colors.color10), PENDING = (":foreground " .. colors.color5 .. " :background " .. colors.color10), IN_REVIEW = (":foreground " .. colors.color5 .. " :background " .. colors.color10), DONE = (":foreground " .. colors.color5 .. " :background " .. colors.color13), CANCELED = (":foreground " .. colors.color5 .. " :background " .. colors.color9)}, org_startup_folded = "overview", org_capture_templates = {t = {description = "\239\128\140 Add a new task to inbox", template = __3etmplstr("task.org"), target = inbox, headline = "Tasks"}, n = {description = "\239\137\137 Add a new note to inbox", subtemplates = {c = {description = "\243\176\133\180 code-reading note", template = __3etmplstr("code-note.org"), target = inbox, headline = "Notes"}, d = {description = "\239\137\137 default note", template = __3etmplstr("note.org"), target = inbox, headline = "Notes"}, l = {description = "\239\145\140 with link", template = __3etmplstr("link.org"), target = inbox, headline = "Notes"}, p = {description = "\239\129\191 with clipboard content", template = __3etmplstr("paste.org"), target = inbox, headline = "Notes"}}}, i = {description = "\239\144\128 Add a new idea", template = __3etmplstr("idea.org"), target = inbox, headline = "Ideas"}, s = {description = "\239\128\133 Add a new topic", template = __3etmplstr("topic.org"), target = inbox, headline = "Topics"}, j = {description = "\243\176\131\173 Add a new note to journal", template = __3etmplstr("journal.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}, d = {description = "\243\176\131\173 Add a new daily report to journal", template = __3etmplstr("daily-report.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}, r = {description = "\243\176\141\163 Add a new review task to journal", template = __3etmplstr("task-review.org"), target = __3epath("journal/%<%Y-%m>.org"), datetree = {tree_type = "day"}}}, calendar_week_start_day = 0, org_deadline_warning_days = 7, org_tags_column = 90, org_id_link_to_org_use_id = true, org_custom_exports = {c = {label = "Export whole document to clipboard", action = _4_}, x = {label = "Export closest headline to clipboard", action = _8_}, d = {label = "Export to PDF file via pandoc & xelatex", action = _12_}}, win_split_mode = "auto", org_highlight_latex_and_related = "entities", org_hide_emphasis_markers = true, notifications = {enabled = true, repeater_reminder_time = {0, 5, 10, 15}, deadline_warning_reminder_time = {0, 5, 10, 15}, reminder_time = {0, 5, 10, 15}, notifier = _15_, cron_enabled = false}, ui = {input = {use_vim_ui = true}, menu = {handler = _17_}}})
roam.setup({directory = __3epath("roam"), org_files = {inbox, __3epath("journal/*.org")}, templates = {f = {description = "\243\176\142\154 fleeting", template = __3etmplstr("roam/fleeting.org"), target = "fleeting%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, w = {description = "\243\176\150\172 wiki", template = __3etmplstr("roam/wiki.org"), target = "wiki%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, p = {description = "\239\148\131 project", template = __3etmplstr("roam/project.org"), target = "project%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, c = {description = "\239\132\161 code", template = __3etmplstr("roam/code.org"), target = "code%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, b = {description = "\239\144\133 book", template = __3etmplstr("roam/book.org"), target = "book%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}, s = {description = "\239\132\174 scrap", template = __3etmplstr("roam/scrap.org"), target = "scrap/%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}}})
bullets.setup({symbols = icon["org-bullets"], concealcursor = false})
local function open_fn(filepath)
  local function _18_()
    return vim.cmd(("e " .. filepath))
  end
  return _18_
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
  local function _19_()
    local tb = require("telescope.builtin")
    return tb.live_grep({cwd = path, type_filter = "org", additional_args = {"--no-ignore-vcs"}})
  end
  return _19_
end
vim.api.nvim_create_user_command("OrgLiveGrep", live_grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamLiveGrep", live_grep_fn(__3epath("roam")), {})
local function grep_fn(path)
  local function _20_()
    local query = vim.fn.input("Grep: ")
    local tb = require("telescope.builtin")
    if (query and not (query == "")) then
      return tb.grep_string({prompt_title = ("Grep for: " .. query), cwd = path, use_regex = true, additional_args = {"--no-ignore-vcs"}, search = vim.fn["kensaku#query"](query, {rxop = vim.g["kensaku#rxop#javascript"]})})
    else
      return nil
    end
  end
  return _20_
end
vim.api.nvim_create_user_command("OrgGrep", grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamGrep", grep_fn(__3epath("roam")), {})
local function refile_to_today()
  local t = require("telescope")
  local date = os.date("%Y-%m-%d %A")
  return t.extensions.orgmode.refile_heading({default_text = date})
end
vim.api.nvim_create_user_command("OrgRefileToToday", refile_to_today, {})
local function roam_pull()
  return Snacks.terminal.open("bb pull", {cwd = __3epath("roam"), interactive = false})
end
vim.api.nvim_create_user_command("RoamPull", roam_pull, {})
local function roam_commit_push()
  return Snacks.terminal.open("bb push", {cwd = __3epath("roam"), interactive = false})
end
vim.api.nvim_create_user_command("RoamCommitPush", roam_commit_push, {})
local function roam_status()
  return Snacks.terminal.open("bb status", {cwd = __3epath("roam"), interactive = false})
end
vim.api.nvim_create_user_command("RoamStatus", roam_status, {})
local function build_todays_agenda()
  local orgmode0 = require("orgmode")
  local agenda_types = require("orgmode.agenda.types")
  local view_opts = vim.tbl_extend("force", {}, {files = orgmode0.agenda.files, agenda_filter = orgmode0.agenda.filters, highlighter = orgmode0.agenda.highlighter, span = "day"})
  local view = agenda_types.agenda:new(view_opts)
  local agenda_day = view:_get_agenda_days()[1]
  local items = agenda_day.agenda_items
  local _22_
  do
    local tbl_21_auto = {}
    local i_22_auto = 0
    for _, item in ipairs(items) do
      local val_23_auto
      do
        local entry = view:_build_line(item, agenda_day)
        local line = entry:compile()
        if ((entry.metadata.agenda_item.headline_date.type == "SCHEDULED") and entry.metadata.agenda_item.is_same_day) then
          val_23_auto = string.gsub(string.gsub(line.content, "^(%s+)([^%s]+):(%s+)", ""), "Scheduled:%s(%u+)%s", "")
        else
          val_23_auto = nil
        end
      end
      if (nil ~= val_23_auto) then
        i_22_auto = (i_22_auto + 1)
        tbl_21_auto[i_22_auto] = val_23_auto
      else
      end
    end
    _22_ = tbl_21_auto
  end
  return table.concat(_22_, "\n")
end
return {build_todays_agenda = build_todays_agenda}
