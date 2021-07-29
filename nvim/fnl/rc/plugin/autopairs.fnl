(module rc.plugin.autopairs
  {autoload {autopairs nvim-autopairs
             rule nvim-autopairs.rule
             compe nvim-autopairs.completion.compe}})

(autopairs.setup {})

;; compe integration
(compe.setup {:map_cr true
              :map_complete true})
