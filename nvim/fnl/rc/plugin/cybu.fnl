(local cybu (require :cybu))

(import-macros {: map!} :rc.macros)

(cybu.setup
  {:position
   {:anchor :bottomright}
   :style
   {:path :tail
    :border :rounded}
   :display_time 1000})

(map! [:n] :gt ":<C-u>lua require('cybu').cycle('next')<CR>" {:silent true})
(map! [:n] :gT ":<C-u>lua require('cybu').cycle('prev')<CR>" {:silent true})
