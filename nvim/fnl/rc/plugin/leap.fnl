(import-macros {: map!} :rc.macros)

(vim.keymap.del :n :ZQ)
(vim.keymap.del :n :ZZ)

(map! [:n :x :o] :z "<Plug>(leap-forward)" {})
(map! [:n :x :o] :Z "<Plug>(leap-backward)" {})
