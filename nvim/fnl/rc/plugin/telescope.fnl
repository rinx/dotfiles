(local {: autoload} (require :nfnl.module))

(local telescope (require :telescope))
(local actions (require :telescope.actions))
(local finders (require :telescope.finders))
(local pickers (require :telescope.pickers))
(local previewers (require :telescope.previewers))
(local sorters (require :telescope.sorters))
(local themes (require :telescope.themes))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

(local action-cmds
  ["cd %:p:h"
   "lua Snacks.git.blame_line()"
   "lua Snacks.gitbrowse()"
   "lua Snacks.lazygit()"
   "lua Snacks.notifier.hide()"
   "lua Snacks.notifier.show_history()"
   "lua Snacks.picker.notifications()"
   "lua Snacks.terminal.toggle()"
   "lua Snacks.terminal.open()"
   :AvanteAsk
   :AvanteChat
   :AvanteToggle
   :ConjureConnect
   :ConjureLogSplit
   :ConjureLogVSplit
   :ConjureCljDebugInit
   :DapContinue
   :DapListBreakpoints
   :DapStepInto
   :DapStepOut
   :DapStepOver
   :DapToggleBreakpoint
   :DapViewToggle
   :Ghq
   :Inspect
   :InspectTree
   :Lazy
   "Lazy check"
   "Lazy update"
   "Lazy profile"
   :LspInfo
   :LspRestart
   :LspStart
   :LspStop
   :MCPHub
   :NvimTreeRefresh
   :NvimTreeToggle
   "Octo pr list"
   "Octo issue list"
   :OrgFind
   :OrgGrep
   :OrgKensaku
   :OrgInbox
   :OrgJournal
   :OrgRefileToToday
   :RoamCommitPush
   :RoamGrep
   :RoamKensaku
   :RoamPull
   :RoamRefreshSearchIndex
   :RoamStatus
   "Telescope dap list_breakpoints"
   "Telescope repo list"
   "Telescope projects"
   "Telescope orgmode refile_heading"
   "Telescope orgmode search_headings"
   "Telescope orgmode insert_link"
   "TelescopeRoamNodesByTag book"
   "TelescopeRoamNodesByTag code"
   "TelescopeRoamNodesByTag fleeting"
   "TelescopeRoamNodesByTag project"
   "TelescopeRoamNodesByTag scrap"
   "TelescopeRoamNodesByTag wiki"
   :TodoTrouble
   :TroubleToggle
   "TroubleToggle loclist"
   "TroubleToggle lsp_document_diagnostics"
   "TroubleToggle lsp_references"
   "TroubleToggle lsp_workspace_diagnostics"
   "TroubleToggle quickfix"])

(telescope.setup
  {:defaults
   {:mappings
    {:i {:<Up> actions.cycle_history_prev
         :<Down> actions.cycle_history_next}}
    :prompt_prefix (.. icontab.search " ")
    :selection_caret (.. icontab.rquot " ")
    :sorting_strategy :ascending
    :scroll_strategy :cycle}
   :extensions
   {:fzy_native
    {:override_generic_sorter true
     :override_file_sorter true}}})

(telescope.load_extension :dap)
(telescope.load_extension :projects)
(telescope.load_extension :repo)
(telescope.load_extension :orgmode)

(fn telescope-ghq []
  (telescope.extensions.repo.list
    {:search_dirs ["~/local/src"]}))
(vim.api.nvim_create_user_command :Ghq telescope-ghq {})

(fn telescope-actions []
  (let [p (pickers.new
            (themes.get_dropdown {})
            {:prompt_title :Actions
             :finder (finders.new_table {:results action-cmds})
             :sorter (sorters.get_fzy_sorter)
             :attach_mappings (fn [_ map]
                                (map :i :<CR> actions.set_command_line)
                                true)})]
    (p:find)))
(vim.api.nvim_create_user_command :TelescopeActions telescope-actions {})

(fn telescope-roam-nodes-by-tag [opts]
  (let [tag (. opts.fargs 1)
        roam (require :org-roam)
        results (roam.database:find_nodes_by_tag_sync tag)
        entry-maker (fn [entry]
                      {:value entry
                       :ordinal (.. entry.title
                                    ","
                                    (table.concat entry.aliases ","))
                       :display entry.title
                       :path entry.file})
        p (pickers.new
            {}
            {:prompt_title "Find roam nodes by tag"
             :finder (finders.new_table {:results results
                                         :entry_maker entry-maker})
             :sorter (sorters.get_fzy_sorter)
             :previewer (previewers.cat.new {})})]
    (p:find)))
(vim.api.nvim_create_user_command :TelescopeRoamNodesByTag telescope-roam-nodes-by-tag {:nargs 1})

(map! [:n] :<Leader>h ":<C-u>TelescopeActions<CR>" {:silent true
                                                    :desc "Select action via telescope"})
