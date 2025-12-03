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
(telescope.load_extension :repo)
(telescope.load_extension :orgmode)

(fn telescope-ghq []
  (telescope.extensions.repo.list
    {:search_dirs ["~/local/src"]}))
(vim.api.nvim_create_user_command :Ghq telescope-ghq {})
