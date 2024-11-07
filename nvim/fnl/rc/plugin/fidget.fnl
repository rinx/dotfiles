(local {: autoload} (require :nfnl.module))

(local fidget (require :fidget))
(local spinner (require :fidget.spinner))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(fidget.setup
  {:progress
   {:display
    {:progress_icon
     (spinner.animate icon.spinners)
     :done_icon icontab.check}}})
