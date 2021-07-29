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
(def- nnoremap-silent util.nnoremap-silent)
(def- loaded? util.loaded?)

(def- action-cmds
  [:ConjureConnect
   :ConjureLogSplit
   :DapContinue
   :DapListBreakpoints
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
   :LspInfo
   :LspRestart
   :LspStart
   :LspStop
   :MarkdownPreview
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

(defn telescope-git-status []
  (builtin.git_status
    {:previewer (previewers.new_termopen_previewer
                  {:get_command
                   (fn [entry]
                     [:git :-c :core.pager=delta
                      :-c :delta.side-by-side=false :diff
                      entry.value])})}))
(nvim.ex.command_ :TelescopeGitStatus (->viml :telescope-git-status))

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
(nvim.ex.command_ :TelescopeActions (->viml :telescope-actions))

(nnoremap-silent ",f" ":<C-u>Telescope fd<CR>")
(nnoremap-silent ",af"
                 ":<C-u>Telescope find_files find_command=fd,--hidden<CR>")
(nnoremap-silent ",of" ":<C-u>Telescope oldfiles<CR>")
(nnoremap-silent ",gf" ":<C-u>Telescope git_files<CR>")
(nnoremap-silent ",gb" ":<C-u>Telescope git_branches<CR>")
(nnoremap-silent ",gc" ":<C-u>Telescope git_commits<CR>")
(nnoremap-silent ",gs" ":<C-u>TelescopeGitStatus<CR>")
(nnoremap-silent ",g" ":<C-u>Telescope live_grep<CR>")
(nnoremap-silent ",/" ":<C-u>Telescope current_buffer_fuzzy_find<CR>")
(nnoremap-silent ",b" ":<C-u>Telescope buffers<CR>")
(nnoremap-silent ",t" ":<C-u>Telescope filetypes<CR>")
(nnoremap-silent ",c"
                 ":<C-u>Telescope command_history theme=get_dropdown<CR>")
(nnoremap-silent ",h" ":<C-u>Telescope help_tags<CR>")
(nnoremap-silent :<Leader><Leader>
                 ":<C-u>Telescope commands theme=get_dropdown<CR>")
(nnoremap-silent :<C-\> ":<C-u>Telescope builtin<CR>")
(nnoremap-silent :<Leader>h ":<C-u>TelescopeActions<CR>")
