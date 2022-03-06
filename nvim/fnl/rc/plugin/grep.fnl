(module rc.plugin.grep
  {autoload {core aniseed.core
             nvim aniseed.nvim
             icon rc.icon}
   require-macros [rc.macros]})

(def- icontab icon.tab)

(defn rg [args]
  (vim.fn.ripgrep#search args))

(defn callback [query]
  (when query
    (rg query)))

(defn rg-input []
  (vim.ui.input
    {:prompt icontab.search
     :completion :file}
    callback))

(nvim.ex.command_ :Rg (->viml! :rg-input))
(noremap! [:n] :<Leader>g ":<C-u>Rg<CR>" :silent)