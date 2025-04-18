-- [nfnl] Compiled from fnl/rc/plugin/avante.fnl by https://github.com/Olical/nfnl, do not edit.
local avante = require("avante")
local mcphub = require("mcphub")
local orgmode_server
local function _1_(req, res)
  local orgmode = require("orgmode")
  local agenda_types = require("orgmode.agenda.types")
  local view_opts = vim.tbl_extend("force", {}, {files = orgmode.agenda.files, agenda_filter = orgmode.agenda.filters, highlighter = orgmode.agenda.highlighter, span = "day"})
  local view = agenda_types.agenda:new(view_opts)
  local agenda_day = view:_get_agenda_days()[1]
  local items = agenda_day.agenda_items
  local _2_
  do
    local tbl_109_auto = {}
    local i_110_auto = 0
    for _, item in ipairs(items) do
      local val_111_auto
      do
        local entry = view:_build_line(item, agenda_day)
        local line = entry:compile()
        val_111_auto = line.content
      end
      if (nil ~= val_111_auto) then
        i_110_auto = (i_110_auto + 1)
        tbl_109_auto[i_110_auto] = val_111_auto
      else
      end
    end
    _2_ = tbl_109_auto
  end
  return res:text(table.concat(_2_, "\n"))
end
orgmode_server = {name = "orgmode", displayName = "Orgmode", capabilities = {tools = {{name = "get_todays_agenda", description = "Get today's agenda by using orgmode agenda API", inputSchema = {}, handler = _1_}}, resources = {}, resourceTemplates = {}}}
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {make_slash_commands = true}}, native_servers = {org = orgmode_server}, auto_approve = false})
local function _4_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _5_()
  local ext = require("mcphub.extensions.avante")
  return {ext.mcp_tool()}
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, hints = {enabled = false}, file_selector = {provider = "snacks"}, system_prompt = _4_, custom_tools = _5_, disabled_tools = {"bash", "create_dir", "create_file", "delete_dir", "delete_file", "list_files", "python", "rag_search", "read_file", "rename_dir", "rename_file", "search_files", "web_search"}})
