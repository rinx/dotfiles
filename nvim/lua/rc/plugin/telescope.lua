-- [nfnl] Compiled from fnl/rc/plugin/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")
local toggleterm = require("telescope-toggleterm")
local icon = autoload("rc.icon")
local icontab = icon.tab
local action_cmds = {"cd %:p:h", "BlamerToggle", "ConjureConnect", "ConjureLogSplit", "DapContinue", "DapListBreakpoints", "DapLoadLaunchJSON", "DapStepInto", "DapStepOut", "DapStepOver", "DapSyncGoAdapter", "DapSyncKotlinAdapter", "DapSyncLLDBAdapter", "DapToggleBreakpoint", "DapUIClose", "DapUIOpen", "DapUIToggle", "GhostStart", "Ghq", "Glance", "Lazy", "Lazy check", "Lazy update", "Lazy profile", "LspInfo", "LspRestart", "LspStart", "LspStart denols", "LspStart tsserver", "LspStop", "NvimTreeRefresh", "NvimTreeToggle", "Octo pr list", "Octo issue list", "Telescope dap list_breakpoints", "Telescope repo list", "Telescope notify", "Telescope projects", "Telescope toggleterm", "ToggleTerm", "ToggleTermCloseAll", "ToggleTermOpenAll", "TodoTrouble", "TroubleToggle", "TroubleToggle loclist", "TroubleToggle lsp_document_diagnostics", "TroubleToggle lsp_references", "TroubleToggle lsp_workspace_diagnostics", "TroubleToggle quickfix"}
telescope.setup({defaults = {mappings = {i = {["<Up>"] = actions.cycle_history_prev, ["<Down>"] = actions.cycle_history_next}}, prompt_prefix = (icontab.search .. " "), selection_caret = (icontab.rquot .. " "), sorting_strategy = "ascending", scroll_strategy = "cycle"}, extensions = {fzy_native = {override_generic_sorter = true, override_file_sorter = true}}})
telescope.load_extension("dap")
telescope.load_extension("notify")
telescope.load_extension("projects")
telescope.load_extension("repo")
telescope.load_extension("toggleterm")
local function telescope_ghq()
  return telescope.extensions.repo.list({search_dirs = {"~/local/src"}})
end
vim.api.nvim_create_user_command("Ghq", telescope_ghq, {})
toggleterm.setup({telescope_mappings = {["<C-c>"] = actions.close}})
local function telescope_git_status()
  local function _2_(entry)
    return {"git", "-c", "core.pager=delta", "-c", "delta.side-by-side=false", "diff", entry.value}
  end
  return builtin.git_status({previewer = previewers.new_termopen_previewer({get_command = _2_})})
end
vim.api.nvim_create_user_command("TelescopeGitStatus", telescope_git_status, {})
local function telescope_actions()
  local p
  local function _3_(_, map)
    map("i", "<CR>", actions.set_command_line)
    return true
  end
  p = pickers.new(themes.get_dropdown({}), {prompt_title = "Actions", finder = finders.new_table({results = action_cmds}), sorter = sorters.get_fzy_sorter(), attach_mappings = _3_})
  return p:find()
end
vim.api.nvim_create_user_command("TelescopeActions", telescope_actions, {})
vim.keymap.set("n", ",f", ":<C-u>Telescope fd<CR>", {silent = true})
vim.keymap.set("n", ",af", ":<C-u>Telescope find_files find_command=fd,--hidden<CR>", {silent = true})
vim.keymap.set("n", ",of", ":<C-u>Telescope oldfiles<CR>", {silent = true})
vim.keymap.set("n", ",gf", ":<C-u>Telescope git_files<CR>", {silent = true})
vim.keymap.set("n", ",gb", ":<C-u>Telescope git_branches<CR>", {silent = true})
vim.keymap.set("n", ",gc", ":<C-u>Telescope git_commits<CR>", {silent = true})
vim.keymap.set("n", ",gs", ":<C-u>TelescopeGitStatus<CR>", {silent = true})
vim.keymap.set("n", ",g", ":<C-u>Telescope live_grep<CR>", {silent = true})
vim.keymap.set("n", ",/", ":<C-u>Telescope current_buffer_fuzzy_find<CR>", {silent = true})
vim.keymap.set("n", ",b", ":<C-u>Telescope buffers<CR>", {silent = true})
vim.keymap.set("n", ",t", ":<C-u>Telescope filetypes<CR>", {silent = true})
vim.keymap.set("n", ",c", ":<C-u>Telescope command_history theme=get_dropdown<CR>", {silent = true})
vim.keymap.set("n", ",h", ":<C-u>Telescope help_tags<CR>", {silent = true})
vim.keymap.set("n", "<Leader><Leader>", ":<C-u>Telescope commands theme=get_dropdown<CR>", {silent = true})
vim.keymap.set("n", "<C-\\>", ":<C-u>Telescope builtin<CR>", {silent = true})
return vim.keymap.set("n", "<Leader>h", ":<C-u>TelescopeActions<CR>", {silent = true})
