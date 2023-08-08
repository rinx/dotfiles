(local neogen (require :neogen))

(import-macros {: map!} :rc.macros)

(neogen.setup
  {:enabled true})

(map!
  [:n]
  :<Leader>n
  ":<C-u>lua require('neogen').generate()<CR>"
  {:silent true})
