(module rc.plugin.noice
  {autoload {nvim aniseed.nvim
             core aniseed.core
             noice noice}
   require-macros [rc.macros]})

(defn setup-noice []
  (noice.setup {}))

;; lazy setup for headless nvim
(augroup! init-noice
          (autocmd! :UIEnter "*" (->viml! :setup-noice)))
