-- [nfnl] Compiled from fnl/rc/plugin/avante.fnl by https://github.com/Olical/nfnl, do not edit.
local avante = require("avante")
local mcphub = require("mcphub")
local orgmode_server
do
  local get_agenda
  local function _1_(span, year, month, day)
    local orgmode = require("orgmode")
    local agenda_types = require("orgmode.agenda.types")
    local date = require("orgmode.objects.date")
    local from
    if (year and month and day) then
      from = date.from_string(vim.fn.printf("%04d-%02d-%02d", year, month, day))
    else
      from = nil
    end
    local view_opts = vim.tbl_extend("force", {}, {files = orgmode.agenda.files, agenda_filter = orgmode.agenda.filters, highlighter = orgmode.agenda.highlighter, span = span, from = from})
    local view = agenda_types.agenda:new(view_opts)
    local tbl_21_auto = {}
    local i_22_auto = 0
    for _, agenda_day in ipairs(view:_get_agenda_days()) do
      local val_23_auto
      do
        local agenda
        local _3_
        do
          local tbl_21_auto0 = {}
          local i_22_auto0 = 0
          for _0, item in ipairs(agenda_day.agenda_items) do
            local val_23_auto0
            do
              local entry = view:_build_line(item, agenda_day)
              local line = entry:compile()
              val_23_auto0 = line.content
            end
            if (nil ~= val_23_auto0) then
              i_22_auto0 = (i_22_auto0 + 1)
              tbl_21_auto0[i_22_auto0] = val_23_auto0
            else
            end
          end
          _3_ = tbl_21_auto0
        end
        agenda = table.concat(_3_, "\n")
        val_23_auto = {year = agenda_day.day.year, month = agenda_day.day.month, day = agenda_day.day.day, agenda = agenda}
      end
      if (nil ~= val_23_auto) then
        i_22_auto = (i_22_auto + 1)
        tbl_21_auto[i_22_auto] = val_23_auto
      else
      end
    end
    return tbl_21_auto
  end
  get_agenda = _1_
  local function _6_(req, res)
    local txt = res:text(vim.json.encode(get_agenda("day", req.params.year, req.params.month, req.params.day)))
    return txt:send()
  end
  local function _7_(req, res)
    local txt = res:text(vim.json.encode(get_agenda("day")))
    return txt:send()
  end
  orgmode_server = {name = "orgmode", displayName = "Orgmode", capabilities = {tools = {{name = "get_agenda_on_specific_date", description = "Get agenda on a specific date", inputSchema = {type = "object", properties = {year = {type = "integer", description = "Year"}, month = {type = "integer", description = "Month"}, day = {type = "integer", description = "Day"}}}, handler = _6_}}, resources = {{name = "todays_agenda", uri = "orgmode://agenda/today", description = "Today's agenda", handler = _7_}}, resourceTemplates = {}}}
end
local orgroam_server
local function _8_(req, res)
  local roam = require("org-roam")
  local ids = roam.database:ids()
  local nodes
  do
    local tbl_21_auto = {}
    local i_22_auto = 0
    for _, id in ipairs(ids) do
      local val_23_auto
      do
        local node = roam.database:get_sync(id)
        val_23_auto = {id = id, title = node.title, aliases = node.aliases}
      end
      if (nil ~= val_23_auto) then
        i_22_auto = (i_22_auto + 1)
        tbl_21_auto[i_22_auto] = val_23_auto
      else
      end
    end
    nodes = tbl_21_auto
  end
  local txt = res:text(vim.json.encode(nodes))
  return txt:send()
end
local function _10_(req, res)
  local roam = require("org-roam")
  local node = roam.database:get_sync(req.params.id)
  local txt = res:text(vim.fn.join(vim.fn.readfile(node.file), "\n"))
  return txt:send()
end
orgroam_server = {name = "orgroam", displayName = "Org-roam", capabilities = {tools = {}, resources = {{name = "list_roam_nodes", uri = "orgroam://nodes", description = "List all org-roam nodes with its ID, title and aliases. The result should be formatted as JSON.", handler = _8_}}, resourceTemplates = {{name = "get_roam_node_content", uriTemplate = "orgroam://nodes/{id}", description = "Get roam node content by specified id. The result should be org-mode formatted text.", handler = _10_}}}}
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {make_slash_commands = true}}, native_servers = {org = orgmode_server, orgroam = orgroam_server}, auto_approve = false})
local function _11_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _12_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, hints = {enabled = false}, file_selector = {provider = "snacks"}, system_prompt = _11_, custom_tools = _12_, disabled_tools = {"bash", "create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
