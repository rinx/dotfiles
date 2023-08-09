(local {: autoload} (require :nfnl.module))

(local fidget (require :fidget))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(fidget.setup
  {:text {:spinner icon.spinners
          :done icontab.check}})
