-- [nfnl] Compiled from fnl/rc/plugin/avante.fnl by https://github.com/Olical/nfnl, do not edit.
local avante = require("avante")
local mcphub = require("mcphub")
mcphub.setup({config = vim.fn.expand("~/.nix-profile/config/mcp-servers.json"), extensions = {avante = {}}})
local function _1_()
  local hub = mcphub.get_hub_instance()
  return hub:get_active_servers_prompt()
end
local function _2_()
  local ext = require("mcphub.extensions.avante")
  return ext.mcp_tool()
end
return avante.setup({provider = "copilot", behavior = {auto_apply_diff_after_generation = true, auto_set_keymaps = false, auto_suggestions = false}, copilot = {model = "claude-3.7-sonnet"}, hints = {enabled = false}, file_selector = {provider = "snacks"}, system_prompt = _1_, custom_tools = _2_, disabled_tools = {"list_files", "search_files", "read_file", "create_file", "rename_file", "delete_file", "create_dir", "rename_dir", "delete_dir", "bash"}})
