-- [nfnl] fnl/rc/plugin/avante.fnl
local avante = require("avante")
local mcphub = require("mcphub")
local org_mode_server
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
org_mode_server = {name = "org-mode", displayName = "Org-mode", capabilities = {tools = {{name = "get_agenda_on_specific_date", description = "Get agenda on a specific date", inputSchema = {type = "object", properties = {year = {type = "number", description = "Year"}, month = {type = "number", description = "Month"}, day = {type = "number", description = "Day"}}, required = {"year", "month", "day"}}, handler = _1_}, {name = "get_agendas_on_specific_month", description = "Get agendas on a specific month", inputSchema = {type = "object", properties = {year = {type = "number", description = "Year"}, month = {type = "number", description = "Month"}}, required = {"year", "month"}}, handler = _2_}}, resources = {{name = "todays_agenda", uri = "orgmode://agenda/today", description = "Today's agenda", handler = _3_}, {name = "agendas_on_this_week", uri = "orgmode://agenda/this-week", description = "Agendas on this week", handler = _4_}}, resourceTemplates = {}}}
local org_roam_server
local function _5_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local callback
  local function _6_(result)
    local txt = res:text(result)
    return txt:send()
  end
  callback = _6_
  local ecallback
  local function _7_(e)
    local err = res:error(e)
    return err:send()
  end
  ecallback = _7_
  return orgrc.query_roam_headings(req.params.query, req.params.limit, callback, ecallback)
end
local function _8_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local callback
  local function _9_(result)
    local txt = res:text(result)
    return txt:send()
  end
  callback = _9_
  local ecallback
  local function _10_(e)
    local err = res:error(e)
    return err:send()
  end
  ecallback = _10_
  return orgrc.query_roam_fragments(req.params.query, req.params.limit, callback, ecallback)
end
local function _11_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local body = ("#+AUTHOR: avante.nvim\n\n" .. req.params.body)
  local callback
  local function _12_(id)
    local txt = res:text(id)
    return txt:send()
  end
  callback = _12_
  return orgrc.create_roam_node(req.params.title, body, callback)
end
local function _13_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local node = orgrc.get_roam_node_by_id(req.params.id)
  if vim.uv.fs_stat(node.file) then
    vim.cmd.badd(node.file)
    local txt = res:text("opened")
    return txt:send()
  else
    local txt = res:error("not found")
    return txt:send()
  end
end
local function _15_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local txt = res:text(vim.json.encode(orgrc.get_roam_heading_content(req.params.id, req.params.title)))
  return txt:send()
end
local function _16_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local nodes = orgrc.get_all_roam_nodes()
  local txt = res:text(vim.json.encode(nodes))
  return txt:send()
end
local function _17_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local node = orgrc.get_roam_node_by_id(req.params.id)
  local txt = res:text(vim.fn.join(vim.fn.readfile(node.file), "\n"))
  return txt:send()
end
local function _18_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local links = orgrc.get_roam_node_links(req.params.id)
  local txt = res:text(vim.json.encode(links))
  return txt:send()
end
local function _19_(req, res)
  local orgrc = require("rc.plugin.orgmode")
  local backlinks = orgrc.get_roam_node_backlinks(req.params.id)
  local txt = res:text(vim.json.encode(backlinks))
  return txt:send()
end
org_roam_server = {name = "org-roam", displayName = "Org-roam", capabilities = {tools = {{name = "search_roam_node_headings", description = "Search for org-roam note headings. This search function is hybrid of vector similarity search and full-text search. The result should be formatted as JSON. It returns node ID, category, content and score for limited number of results.", inputSchema = {type = "object", properties = {query = {type = "string", description = "Query string used for semantic search"}, limit = {type = "number", description = "The number of top-k result"}}, required = {"query", "limit"}}, handler = _5_}, {name = "search_roam_node_fragments", description = "Search for org-roam note fragments. This search function is hybrid of vector similarity search and full-text search. The result should be formatted as JSON. It returns node ID, category, content and score for limited number of results.", inputSchema = {type = "object", properties = {query = {type = "string", description = "Query string used for semantic search"}, limit = {type = "number", description = "The number of top-k result"}}, required = {"query", "limit"}}, handler = _8_}, {name = "create_roam_node", description = "Create a new org-roam note. The result should be roam node ID.", inputSchema = {type = "object", properties = {title = {type = "string", description = "Title of the newly created note"}, body = {type = "string", description = "Body of the newly created note. It should be formatted as org-mode style."}}, required = {"title", "body"}}, handler = _11_}, {name = "open_roam_node", description = "Open specified org-roam note as a neovim buffer.", inputSchema = {type = "object", properties = {id = {type = "string", description = "node ID"}}, required = {"id"}}, handler = _13_}, {name = "get_roam_heading_content", description = "Get roam note heading content by specified id and heading title. The result should be a JSON formatted list of found objects. The object is composed by node metadata, file path, heading title, heading level, content lines, children headings and position.", inputSchema = {type = "object", properties = {id = {type = "string", description = "node ID"}, title = {type = "string", description = "title of the heading"}}, required = {"id", "title"}}, handler = _15_}}, resources = {{name = "list_roam_nodes", uri = "orgroam://nodes", description = "List all org-roam notes with its ID, title and aliases. The result should be formatted as JSON.", handler = _16_}}, resourceTemplates = {{name = "get_roam_node_content", uriTemplate = "orgroam://nodes/{id}", description = "Get roam note content by specified id. The result should be org-mode formatted text.", handler = _17_}, {name = "get_roam_node_links", uriTemplate = "orgroam://nodes/{id}/links", description = "Get roam note links. The result should be formatted as JSON. Key-value pairs of node id and distance.", handler = _18_}, {name = "get_roam_node_backlinks", uriTemplate = "orgroam://nodes/{id}/backlinks", description = "Get roam note backlinks. The result should be formatted as JSON. Key-value pairs of node id and distance.", handler = _19_}}}}
local function _20_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _21_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, enable_cursor_planning_mode = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, vendors = {["copilot-gemini-2.5-pro"] = {__inherited_from = "copilot", model = "gemini-2.5-pro"}, ["copilot-gpt-4.1"] = {__inherited_from = "copilot", model = "gpt-4.1"}, ["copilot-gpt-4o"] = {__inherited_from = "copilot", model = "gpt-4o"}}, hints = {enabled = false}, file_selector = {provider = "snacks"}, mappings = {ask = "<leader>Aa", edit = "<leader>Ae", refresh = "<leader>Ar", focus = "<leader>Af", stop = "<leader>AS", toggle = {default = "<leader>At", debug = "<leader>Ad", hint = "<leader>Ah", suggestion = "<leader>As", repomap = "<leader>AR"}, files = {add_current = "<leader>Ac", add_all_buffers = "<leader>AB"}, select_model = "<leader>A?", select_history = "<leader>AH"}, system_prompt = _20_, custom_tools = _21_, disabled_tools = {"create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
mcphub.setup({auto_toggle_mcp_servers = true, config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {enabled = true, make_slash_commands = true}}, native_servers = {["org-mode"] = org_mode_server, ["org-roam"] = org_roam_server}, auto_approve = false})
local toggle
local function _22_()
  return (vim.g.mcphub_auto_approve == true)
end
local function _23_(state)
  if state then
    vim.g.mcphub_auto_approve = true
    return nil
  else
    vim.g.mcphub_auto_approve = false
    return nil
  end
end
toggle = Snacks.toggle.new({id = "mcphub_auto_approve", name = "MCPHub auto_approve", get = _22_, set = _23_})
return toggle:map("<leader>AA")
