(module rc.plugin.notify
  {autoload {nvim aniseed.nvim
             core aniseed.core
             color rc.color
             icon rc.icon
             notify notify}
   require-macros [rc.macros]})

(def- icontab icon.tab)

(defn setup-notify []
  (when (not (core.empty? (nvim.list_uis)))
    (notify.setup
      {:stages :fade_in_slide_out
       :timeout 5000
       :icons {:ERROR icontab.ban
               :WARN icontab.exclam-tri
               :INFO icontab.info-circle
               :DEBUG icontab.bug
               :TRACE icontab.bug}})
    (set vim.notify notify)))

;; lazy setup for headless nvim
(augroup! init-notify
          (autocmd! :UIEnter "*" (->viml! :setup-notify)))
