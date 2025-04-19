-- [nfnl] Compiled from fnl/rc/plugin/avante.fnl by https://github.com/Olical/nfnl, do not edit.
local avante = require("avante")
local mcphub = require("mcphub")
local orgmode_server
do
  local get_agenda
  local function _1_(date_string)
    local orgmode = require("orgmode")
    local agenda_types = require("orgmode.agenda.types")
    local date = require("orgmode.objects.date")
    local from
    if date_string then
      from = date.from_string(date_string)
    else
      from = nil
    end
    local view_opts = vim.tbl_extend("force", {}, {files = orgmode.agenda.files, agenda_filter = orgmode.agenda.filters, highlighter = orgmode.agenda.highlighter, span = "day", from = from})
    local view = agenda_types.agenda:new(view_opts)
    local agenda_day = view:_get_agenda_days()[1]
    local _3_
    do
      local tbl_21_auto = {}
      local i_22_auto = 0
      for _, item in ipairs(agenda_day.agenda_items) do
        local val_23_auto
        do
          local entry = view:_build_line(item, agenda_day)
          local line = entry:compile()
          val_23_auto = line.content
        end
        if (nil ~= val_23_auto) then
          i_22_auto = (i_22_auto + 1)
          tbl_21_auto[i_22_auto] = val_23_auto
        else
        end
      end
      _3_ = tbl_21_auto
    end
    return table.concat(_3_, "\n")
  end
  get_agenda = _1_
  local function _5_(req, res)
    local txt = res:text(get_agenda(req.params.date))
    return txt:send()
  end
  local function _6_(req, res)
    local txt = res:text(get_agenda())
    return txt:send()
  end
  orgmode_server = {name = "orgmode", displayName = "Orgmode", capabilities = {tools = {{name = "get_agenda_on_specific_date", description = "Get agenda on a specific date", inputSchema = {type = "object", properties = {date = {type = "string", description = "date formatted as '2020-01-03'"}}}, handler = _5_}}, resources = {{name = "todays_agenda", uri = "orgmode://agenda/today", description = "Today's agenda", handler = _6_}}, resourceTemplates = {}}}
end
local orgroam_server
local function _7_(req, res)
  local roam = require("org-roam")
  local node = roam.database:get_sync(req.params.id)
  local txt = res:text(vim.fn.join(vim.fn.readfile(node.file), "\n"))
  return txt:send()
end
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
orgroam_server = {name = "orgroam", displayName = "Org-roam", capabilities = {tools = {{name = "get_roam_node_content_by_id", description = "Get roam node content by specified id. The result should be org-mode formatted text.", inputSchema = {type = "object", properties = {id = {type = "string", description = "node ID"}}}, handler = _7_}}, resources = {{name = "list_roam_nodes", uri = "orgroam://nodes", description = "List all org-roam nodes with its ID, title and aliases. The result should be formatted as JSON.", handler = _8_}}}}
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {make_slash_commands = true}}, native_servers = {org = orgmode_server, orgroam = orgroam_server}, auto_approve = false})
local function _10_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _11_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, hints = {enabled = false}, file_selector = {provider = "snacks"}, system_prompt = _10_, custom_tools = _11_, disabled_tools = {"bash", "create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
