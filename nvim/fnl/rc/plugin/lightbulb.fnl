(local {: autoload} (require :nfnl.module))

(local lightbulb (require :nvim-lightbulb))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(lightbulb.setup
  {:autocmd {:enabled true}
   :sign {:enabled true
          :text icontab.lightbulb
          :hl :DiagnosticSignLightBulb}})
