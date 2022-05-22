(module rc.plugin.cybu
  {autoload {nvim aniseed.nvim
             cybu cybu}
   require-macros [rc.macros]})

(cybu.setup
  {:position
   {:anchor :bottomright}
   :style
   {:path :tail
    :border :rounded}
   :display_time 1000})

(noremap! [:n] :gt ":<C-u>lua require('cybu').cycle('next')<CR>" :silent)
(noremap! [:n] :gT ":<C-u>lua require('cybu').cycle('prev')<CR>" :silent)
