(import-macros {: map!} :rc.macros)

(local wk (require :which-key))

(fn which-key-show []
  (wk.show {:global false}))

(map! [:n] :<leader>? which-key-show {})
