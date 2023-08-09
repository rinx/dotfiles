(local {: autoload} (require :nfnl.module))

(local dressing (require :dressing))

(local icon (autoload :rc.icon))
(local icontab icon.tab)

(dressing.setup
  {:input
   {:default_prompt icontab.rquot}})


