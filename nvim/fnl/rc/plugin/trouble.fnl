(local {: autoload} (require :nfnl.module))

(local trouble (require :trouble))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

(trouble.setup {:auto_close true
                :modes {:diagnostics {:auto_open true}}
                :signs {:error icontab.bug
                        :warning icontab.exclam-circle
                        :hint icontab.leaf
                        :information icontab.info-circle
                        :other icontab.comment-alt}
                :action_keys {:switch_severity :S}})
(map! [:n] "<leader>xx" ":<C-u>Trouble diagnostics toggle<CR>" {:silent true})
(map! [:n] "<leader>xX" ":<C-u>Trouble diagnostics toggle filter.buf=0<CR>" {:silent true})
(map! [:n] "<leader>xd" ":<C-u>Trouble lsp toggle<CR>" {:silent true})
(map! [:n] "<leader>xq" ":<C-u>Trouble qflist toggle<CR>" {:silent true})
(map! [:n] "<leader>xl" ":<C-u>Trouble loclist toggle<CR>" {:silent true})
