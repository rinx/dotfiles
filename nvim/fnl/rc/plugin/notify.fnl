(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local notify (require :notify))

(local icon (autoload :rc.icon))
(import-macros {: augroup!} :rc.macros)

(local icontab icon.tab)

(fn setup-notify []
  (when (not (core.empty? (vim.api.nvim_list_uis)))
    (notify.setup
      {:stages :fade_in_slide_out
       :timeout 5000
       :background_colour "#000000"
       :icons {:ERROR icontab.ban
               :WARN icontab.exclam-tri
               :INFO icontab.info-circle
               :DEBUG icontab.bug
               :TRACE icontab.bug}})
    (set vim.notify notify)))

;; lazy setup for headless nvim
(augroup!
  init-notify
  {:events [:UIEnter]
   :pattern :*
   :callback setup-notify})
