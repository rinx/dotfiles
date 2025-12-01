-- [nfnl] fnl/rc/plugin/telescope.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local telescope = require("telescope")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local icon = autoload("rc.icon")
local icontab = icon.tab
telescope.setup({defaults = {mappings = {i = {["<Up>"] = actions.cycle_history_prev, ["<Down>"] = actions.cycle_history_next}}, prompt_prefix = (icontab.search .. " "), selection_caret = (icontab.rquot .. " "), sorting_strategy = "ascending", scroll_strategy = "cycle"}, extensions = {fzy_native = {override_generic_sorter = true, override_file_sorter = true}}})
telescope.load_extension("dap")
telescope.load_extension("repo")
telescope.load_extension("orgmode")
local function telescope_ghq()
  return telescope.extensions.repo.list({search_dirs = {"~/local/src"}})
end
vim.api.nvim_create_user_command("Ghq", telescope_ghq, {})
local function telescope_roam_nodes_by_tag(opts)
  local tag = opts.fargs[1]
  local roam = require("org-roam")
  local results = roam.database:find_nodes_by_tag_sync(tag)
  local entry_maker
  local function _2_(entry)
    return {value = entry, ordinal = (entry.title .. "," .. table.concat(entry.aliases, ",")), display = entry.title, path = entry.file}
  end
  entry_maker = _2_
  local p = pickers.new({}, {prompt_title = "Find roam nodes by tag", finder = finders.new_table({results = results, entry_maker = entry_maker}), sorter = sorters.get_fzy_sorter(), previewer = previewers.cat.new({})})
  return p:find()
end
return vim.api.nvim_create_user_command("TelescopeRoamNodesByTag", telescope_roam_nodes_by_tag, {nargs = 1})
