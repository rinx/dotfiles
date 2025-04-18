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
    return res:text(get_agenda(req.params.date))
  end
  local function _6_(req, res)
    return res:text(get_agenda())
  end
  orgmode_server = {name = "orgmode", displayName = "Orgmode", capabilities = {tools = {{name = "get_agenda_on_specific_date", description = "Get agenda on a specific date", inputSchema = {type = "object", properties = {date = {type = "string", description = "date formatted as '2020-01-03'"}}}, handler = _5_}}, resources = {{name = "todays_agenda", uri = "orgmode://agenda/today", description = "Today's agenda", handler = _6_}}, resourceTemplates = {}}}
end
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {make_slash_commands = true}}, native_servers = {org = orgmode_server}, auto_approve = false})
local function _7_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _8_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, hints = {enabled = false}, file_selector = {provider = "snacks"}, system_prompt = _7_, custom_tools = _8_, disabled_tools = {"bash", "create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
