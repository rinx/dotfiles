(local {: autoload} (require :nfnl.module))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

(fn rg [args]
  (vim.fn.ripgrep#search args))

(fn callback [query]
  (when query
    (rg query)))

(fn rg-input []
  (vim.ui.input
    {:prompt icontab.search
     :completion :file}
    callback))

(vim.api.nvim_create_user_command :Rg rg-input {})
(map! [:n] :<Leader>g ":<C-u>Rg<CR>" {:silent true})
