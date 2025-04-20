-- [nfnl] Compiled from fnl/rc/plugin/orgmode.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icon = autoload("rc.icon")
local color = autoload("rc.color")
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
  local snacks = require("snacks")
  return snacks.picker.files({cwd = basepath, ignored = true})
end
vim.api.nvim_create_user_command("OrgFind", fd_fn, {})
local function live_grep_fn(path)
  local function _19_()
    local snacks = require("snacks")
    return snacks.picker.grep({cwd = path, ignored = true})
  end
  return _19_
end
vim.api.nvim_create_user_command("OrgGrep", live_grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamGrep", live_grep_fn(__3epath("roam")), {})
local function grep_fn(path)
  local function _20_()
    local snacks = require("snacks")
    return snacks.picker.kensaku({cwd = path})
  end
  return _20_
end
vim.api.nvim_create_user_command("OrgKensaku", grep_fn(basepath), {})
vim.api.nvim_create_user_command("RoamKensaku", grep_fn(__3epath("roam")), {})
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
  local _21_
  do
    local tbl_109_auto = {}
    local i_110_auto = 0
    for _, item in ipairs(items) do
      local val_111_auto
      do
        local entry = view:_build_line(item, agenda_day)
        local line = entry:compile()
        if ((entry.metadata.agenda_item.headline_date.type == "SCHEDULED") and entry.metadata.agenda_item.is_same_day and not string.match(line.content, "CANCELED")) then
          val_111_auto = string.gsub(string.gsub(line.content, "^(%s+)([^%s]+):(%s+)", ""), "Scheduled:%s(%u+)%s", "")
        else
          val_111_auto = nil
        end
      end
      if (nil ~= val_111_auto) then
        i_110_auto = (i_110_auto + 1)
        tbl_109_auto[i_110_auto] = val_111_auto
      else
      end
    end
    _21_ = tbl_109_auto
  end
  return table.concat(_21_, "\n")
end
local function get_agenda(span, year, month, day)
  local orgmode0 = require("orgmode")
  local agenda_types = require("orgmode.agenda.types")
  local date = require("orgmode.objects.date")
  local from
  if (year and month and day) then
    from = date.from_string(vim.fn.printf("%04d-%02d-%02d", year, month, day))
  else
    from = nil
  end
  local view_opts = vim.tbl_extend("force", {}, {files = orgmode0.agenda.files, agenda_filter = orgmode0.agenda.filters, highlighter = orgmode0.agenda.highlighter, span = span, from = from})
  local view = agenda_types.agenda:new(view_opts)
  local tbl_109_auto = {}
  local i_110_auto = 0
  for _, agenda_day in ipairs(view:_get_agenda_days()) do
    local val_111_auto
    do
      local agenda
      do
        local tbl_109_auto0 = {}
        local i_110_auto0 = 0
        for _0, item in ipairs(agenda_day.agenda_items) do
          local val_111_auto0
          do
            local entry = view:_build_line(item, agenda_day)
            local line = entry:compile()
            val_111_auto0 = line.content
          end
          if (nil ~= val_111_auto0) then
            i_110_auto0 = (i_110_auto0 + 1)
            tbl_109_auto0[i_110_auto0] = val_111_auto0
          else
          end
        end
        agenda = tbl_109_auto0
      end
      val_111_auto = {year = agenda_day.day.year, month = agenda_day.day.month, day = agenda_day.day.day, agenda = agenda}
    end
    if (nil ~= val_111_auto) then
      i_110_auto = (i_110_auto + 1)
      tbl_109_auto[i_110_auto] = val_111_auto
    else
    end
  end
  return tbl_109_auto
end
local function get_all_roam_nodes()
  local roam0 = require("org-roam")
  local ids = roam0.database:ids()
  local tbl_109_auto = {}
  local i_110_auto = 0
  for _, id in ipairs(ids) do
    local val_111_auto
    do
      local node = roam0.database:get_sync(id)
      val_111_auto = {id = id, title = node.title, aliases = node.aliases}
    end
    if (nil ~= val_111_auto) then
      i_110_auto = (i_110_auto + 1)
      tbl_109_auto[i_110_auto] = val_111_auto
    else
    end
  end
  return tbl_109_auto
end
local function get_roam_node_by_id(id)
  local roam0 = require("org-roam")
  return roam0.database:get_sync(id)
end
local duckdb_dir = vim.fn.expand("~/.cache/nvim/roam_duckdb")
local duckdb_file = (duckdb_dir .. "/roam.duckdb")
if not (vim.fn.isdirectory(duckdb_dir) == 1) then
  vim.fn.mkdir(duckdb_dir, "p")
else
end
local function refresh_roam_vector_indices()
  local started_time = os.time()
  local __3esql
  local function _29_(results)
    local inserts
    local _30_
    do
      local tbl_109_auto = {}
      local i_110_auto = 0
      for _, result in ipairs(results) do
        local val_111_auto = ("INSERT INTO roam_nodes (id, vector) VALUES ('" .. result.id .. "', " .. vim.json.encode(result.vector) .. ")")
        if (nil ~= val_111_auto) then
          i_110_auto = (i_110_auto + 1)
          tbl_109_auto[i_110_auto] = val_111_auto
        else
        end
      end
      _30_ = tbl_109_auto
    end
    inserts = table.concat(_30_, ";")
    return table.concat({"INSTALL vss", "LOAD vss", "CREATE TABLE IF NOT EXISTS roam_nodes (id TEXT, vector FLOAT[2048])", inserts}, ";")
  end
  __3esql = _29_
  vim.fn.delete(duckdb_file)
  local nodes = vim.json.encode(get_all_roam_nodes())
  local function _32_(job)
    if not (job.code == 0) then
      return vim.notify(job.stderr)
    else
      local results = vim.json.decode(job.stdout)
      local sql = __3esql(results)
      local function _33_(job0)
        if (job0.code == 0) then
          local current_time = os.time()
          local took_sec = (current_time - started_time)
          return vim.notify(("finished: took " .. took_sec .. "s"))
        else
          return vim.notify(job0.stderr)
        end
      end
      return vim.system({"duckdb", duckdb_file}, {stdin = sql, text = true}, _33_)
    end
  end
  return vim.system({"plamo-embedding-1b.py", "documents"}, {stdin = nodes, text = true}, _32_)
end
local function search_roam_nodes_by_vector(query, limit)
  local function _36_(job)
    if not (job.code == 0) then
      return vim.notify(job.stderr)
    else
      local query_embedding = job.stdout
      local sql = ("SELECT id, array_cosine_distance(vector, " .. query_embedding .. "::FLOAT[2048]) AS distance FROM roam_nodes ORDER BY distance LIMIT " .. limit .. ";")
      local function _37_(job0)
        if (job0.code == 0) then
          local results = vim.json.decode(job0.stdout)
          local fst = results[1]
          return vim.notify(fst.id)
        else
          return vim.notify(job0.stderr)
        end
      end
      return vim.system({"duckdb", duckdb_file, "--json"}, {stdin = sql, text = true}, _37_)
    end
  end
  return vim.system({"plamo-embedding-1b.py", "query"}, {stdin = query, text = true}, _36_)
end
return {build_todays_agenda = build_todays_agenda, get_agenda = get_agenda, get_all_roam_nodes = get_all_roam_nodes, get_roam_node_by_id = get_roam_node_by_id}
