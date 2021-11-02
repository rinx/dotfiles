(module rc.plugin.telescope
  {autoload {nvim aniseed.nvim
             icon rc.icon
             util rc.util
             telescope telescope
             actions telescope.actions
             builtin telescope.builtin
             finders telescope.finders
             pickers telescope.pickers
             previewers telescope.previewers
             sorters telescope.sorters
             themes telescope.themes}
   require-macros [rc.macros]})

(def- icontab icon.tab)
(def- loaded? util.loaded?)

(def- action-cmds
  [:ConjureConnect
   :ConjureLogSplit
   :DapContinue
   :DapListBreakpoints
   :DapLoadLaunchJSON
   :DapStepInto
   :DapStepOut
   :DapStepOver
   :DapSyncGoAdapter
   :DapSyncKotlinAdapter
   :DapSyncLLDBAdapter
   :DapToggleBreakpoint
   :DapUIClose
   :DapUIOpen
   :DapUIToggle
   :GhostStart
   :LspInfo
   :LspRestart
   :LspStart
   "LspStart denols"
   "LspStart tsserver"
   :LspStop
   :PreviewMarkdownToggle
   :NeorgStart
   "Neorg gtd capture"
   "Neorg gtd views"
   "Neorg workspace gtd"
   "Neorg workspace notes"
   :Notifications
   :NvimTreeRefresh
   :NvimTreeToggle
   :PackerClean
   :PackerCompile
   :PackerInstall
   :PackerStatus
   :PackerSync
   :PackerUpdate
   :SymbolsOutline
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

(when (loaded? :telescope-dap.nvim)
  (telescope.load_extension :dap))

(when (loaded? :telescope-fzy-native.nvim)
  (telescope.load_extension :fzy_native))

(when (loaded? :nvim-notify)
  (telescope.load_extension :notify))

(defn telescope-git-status []
  (builtin.git_status
    {:previewer (previewers.new_termopen_previewer
                  {:get_command
                   (fn [entry]
                     [:git :-c :core.pager=delta
                      :-c :delta.side-by-side=false :diff
                      entry.value])})}))
(nvim.ex.command_ :TelescopeGitStatus (->viml! :telescope-git-status))

(defn telescope-actions []
  (let [p (pickers.new
            (themes.get_dropdown {})
            {:prompt_title :Actions
             :finder (finders.new_table {:results action-cmds})
             :sorter (sorters.get_fzy_sorter)
             :attach_mappings (fn [_ map]
                                (map :i :<CR> actions.set_command_line)
                                true)})]
    (p:find)))
(nvim.ex.command_ :TelescopeActions (->viml! :telescope-actions))

(noremap! [:n] ",f" ":<C-u>Telescope fd<CR>" :silent)
(noremap! [:n]
          ",af"
          ":<C-u>Telescope find_files find_command=fd,--hidden<CR>"
          :silent)
(noremap! [:n] ",of" ":<C-u>Telescope oldfiles<CR>" :silent)
(noremap! [:n] ",gf" ":<C-u>Telescope git_files<CR>" :silent)
(noremap! [:n] ",gb" ":<C-u>Telescope git_branches<CR>" :silent)
(noremap! [:n] ",gc" ":<C-u>Telescope git_commits<CR>" :silent)
(noremap! [:n] ",gs" ":<C-u>TelescopeGitStatus<CR>" :silent)
(noremap! [:n] ",g" ":<C-u>Telescope live_grep<CR>" :silent)
(noremap! [:n] ",/" ":<C-u>Telescope current_buffer_fuzzy_find<CR>" :silent)
(noremap! [:n] ",b" ":<C-u>Telescope buffers<CR>" :silent)
(noremap! [:n] ",t" ":<C-u>Telescope filetypes<CR>" :silent)
(noremap! [:n]
          ",c"
          ":<C-u>Telescope command_history theme=get_dropdown<CR>"
          :silent)
(noremap! [:n] ",h" ":<C-u>Telescope help_tags<CR>" :silent)
(noremap! [:n]
          :<Leader><Leader>
          ":<C-u>Telescope commands theme=get_dropdown<CR>"
          :silent)
(noremap! [:n] :<C-\> ":<C-u>Telescope builtin<CR>" :silent)
(noremap! [:n] :<Leader>h ":<C-u>TelescopeActions<CR>" :silent)
