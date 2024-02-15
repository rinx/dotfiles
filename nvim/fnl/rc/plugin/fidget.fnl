(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local fidget (require :fidget))
(local spinner (require :fidget.spinner))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(import-macros {: augroup!} :rc.macros)

(fidget.setup
  {:progress
   {:display
    {:progress_icon
     (spinner.animate icon.spinners)
     :done_icon icontab.check}}})

(fn setup-notify []
  (when (not (core.empty? (vim.api.nvim_list_uis)))
    (set vim.notify fidget.notify)))

;; lazy setup for headless nvim
(augroup!
  init-notify
  {:events [:UIEnter]
   :pattern :*
   :callback setup-notify})

