(local {: autoload} (require :nfnl.module))

(local telescope (require :telescope))
(local actions (require :telescope.actions))
(local builtin (require :telescope.builtin))
(local finders (require :telescope.finders))
(local pickers (require :telescope.pickers))
(local previewers (require :telescope.previewers))
(local sorters (require :telescope.sorters))
(local themes (require :telescope.themes))
(local toggleterm (require :telescope-toggleterm))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

(local action-cmds
  ["cd %:p:h"
   :BlamerToggle
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
   :DapUIToggle
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
   "LspStart denols"
   "LspStart tsserver"
   :LspStop
   :NvimTreeRefresh
   :NvimTreeToggle
   "Octo pr list"
   "Octo issue list"
   :OrgGrep
   :OrgInbox
   :OrgJournal
   :RoamGrep
   "Fidget history"
   "Telescope dap list_breakpoints"
   "Telescope repo list"
   "Telescope projects"
   "Telescope toggleterm"
   "Telescope orgmode refile_heading"
   "Telescope orgmode search_headings"
   "Telescope orgmode insert_link"
   "TelescopeRoamNodesByTag book"
   "TelescopeRoamNodesByTag code"
   "TelescopeRoamNodesByTag fleeting"
   "TelescopeRoamNodesByTag project"
   "TelescopeRoamNodesByTag scrap"
   "TelescopeRoamNodesByTag wiki"
   :ToggleTerm
   :ToggleTermCloseAll
   :ToggleTermOpenAll
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
(telescope.load_extension :toggleterm)
(telescope.load_extension :orgmode)

(fn telescope-ghq []
  (telescope.extensions.repo.list
    {:search_dirs ["~/local/src"]}))
(vim.api.nvim_create_user_command :Ghq telescope-ghq {})

(toggleterm.setup {:telescope_mappings
                    {:<C-c> actions.close}})

(fn telescope-git-status []
  (builtin.git_status
    {:previewer (previewers.new_termopen_previewer
                  {:get_command
                   (fn [entry]
                     [:git :-c :core.pager=delta
                      :-c :delta.side-by-side=false :diff
                      entry.value])})}))
(vim.api.nvim_create_user_command :TelescopeGitStatus telescope-git-status {})

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

(map! [:n] ",f" ":<C-u>Telescope fd<CR>" {:silent true})
(map! [:n]
      ",af"
      ":<C-u>Telescope find_files find_command=fd,--hidden<CR>"
      {:silent true})
(map! [:n] ",of" ":<C-u>Telescope oldfiles<CR>" {:silent true})
(map! [:n] ",gf" ":<C-u>Telescope git_files<CR>" {:silent true})
(map! [:n] ",gb" ":<C-u>Telescope git_branches<CR>" {:silent true})
(map! [:n] ",gc" ":<C-u>Telescope git_commits<CR>" {:silent true})
(map! [:n] ",gs" ":<C-u>TelescopeGitStatus<CR>" {:silent true})
(map! [:n] ",g" ":<C-u>Telescope live_grep<CR>" {:silent true})
(map! [:n] ",/" ":<C-u>Telescope current_buffer_fuzzy_find<CR>" {:silent true})
(map! [:n] ",b" ":<C-u>Telescope buffers<CR>" {:silent true})
(map! [:n] ",t" ":<C-u>Telescope filetypes<CR>" {:silent true})
(map! [:n]
      ",c"
      ":<C-u>Telescope command_history theme=get_dropdown<CR>"
      {:silent true})
(map! [:n] ",h" ":<C-u>Telescope help_tags<CR>" {:silent true})
(map! [:n]
      :<Leader><Leader>
      ":<C-u>Telescope commands theme=get_dropdown<CR>"
      {:silent true})
(map! [:n] :<C-\> ":<C-u>Telescope builtin<CR>" {:silent true})
(map! [:n] :<Leader>h ":<C-u>TelescopeActions<CR>" {:silent true})
