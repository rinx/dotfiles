-- [nfnl] Compiled from fnl/rc/plugin/avante.fnl by https://github.com/Olical/nfnl, do not edit.
local avante = require("avante")
local mcphub = require("mcphub")
local orgmode_server
local function _1_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local txt = res:text(vim.json.encode(orgrc.get_agenda("day", req.params.year, req.params.month, req.params.day)))
  return txt:send()
end
local function _2_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local txt = res:text(vim.json.encode(orgrc.get_agenda("month", req.params.year, req.params.month, 1)))
  return txt:send()
end
local function _3_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local txt = res:text(vim.json.encode(orgrc.get_agenda("day")))
  return txt:send()
end
local function _4_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local txt = res:text(vim.json.encode(orgrc.get_agenda("week")))
  return txt:send()
end
orgmode_server = {name = "orgmode", displayName = "Orgmode", capabilities = {tools = {{name = "get_agenda_on_specific_date", description = "Get agenda on a specific date", inputSchema = {type = "object", properties = {year = {type = "integer", description = "Year"}, month = {type = "integer", description = "Month"}, day = {type = "integer", description = "Day"}}}, handler = _1_}, {name = "get_agendas_on_specific_month", description = "Get agendas on a specific month", inputSchema = {type = "object", properties = {year = {type = "integer", description = "Year"}, month = {type = "integer", description = "Month"}}}, handler = _2_}}, resources = {{name = "todays_agenda", uri = "orgmode://agenda/today", description = "Today's agenda", handler = _3_}, {name = "agendas_on_this_week", uri = "orgmode://agenda/this-week", description = "Agendas on this week", handler = _4_}}, resourceTemplates = {}}}
local orgroam_server
local function _5_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local nodes = orgrc.get_all_roam_nodes()
  local txt = res:text(vim.json.encode(nodes))
  return txt:send()
end
local function _6_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local node = orgrc.get_roam_node_by_id(req.params.id)
  local txt = res:text(vim.fn.join(vim.fn.readfile(node.file), "\n"))
  return txt:send()
end
orgroam_server = {name = "orgroam", displayName = "Org-roam", capabilities = {tools = {}, resources = {{name = "list_roam_nodes", uri = "orgroam://nodes", description = "List all org-roam nodes with its ID, title and aliases. The result should be formatted as JSON.", handler = _5_}}, resourceTemplates = {{name = "get_roam_node_content", uriTemplate = "orgroam://nodes/{id}", description = "Get roam node content by specified id. The result should be org-mode formatted text.", handler = _6_}}}}
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {make_slash_commands = true}}, native_servers = {org = orgmode_server, orgroam = orgroam_server}, auto_approve = false})
do
  local toggle
  local function _7_()
    return (vim.g.mcphub_auto_approve == true)
  end
  local function _8_(state)
    if state then
      vim.g.mcphub_auto_approve = true
      return nil
    else
      vim.g.mcphub_auto_approve = false
      return nil
    end
  end
  toggle = Snacks.toggle.new({id = "mcphub_auto_approve", name = "MCPHub auto_approve", get = _7_, set = _8_})
  toggle:map("<leader>AA")
end
local function _10_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _11_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, vendors = {["copilot-gemini-2.5-pro"] = {__inherited_from = "copilot", model = "gemini-2.5-pro"}, ["copilot-gpt-4.1"] = {__inherited_from = "copilot", model = "gpt-4.1"}, ["copilot-gpt-4o"] = {__inherited_from = "copilot", model = "gpt-4o"}}, hints = {enabled = false}, file_selector = {provider = "snacks"}, mappings = {ask = "<leader>Aa", edit = "<leader>Ae", refresh = "<leader>Ar", focus = "<leader>Af", stop = "<leader>AS", toggle = {default = "<leader>At", debug = "<leader>Ad", hint = "<leader>Ah", suggestion = "<leader>As", repomap = "<leader>AR"}, files = {add_current = "<leader>Ac", add_all_buffers = "<leader>AB"}, select_model = "<leader>A?", select_history = "<leader>AH"}, system_prompt = _10_, custom_tools = _11_, disabled_tools = {"bash", "create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
