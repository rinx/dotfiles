(local {: autoload} (require :nfnl.module))

(local trouble (require :trouble))

(local icon (autoload :rc.icon))
(import-macros {: map!} :rc.macros)

(local icontab icon.tab)

(trouble.setup {:auto_open true
                :auto_close true
                :signs {:error icontab.bug
                        :warning icontab.exclam-circle
                        :hint icontab.leaf
                        :information icontab.info-circle
                        :other icontab.comment-alt}
                :action_keys {:switch_severity :S}})
(map! [:n] "<leader>xx" ":<C-u>TroubleToggle<CR>" {:silent true})
(map! [:n] "<leader>xw" ":<C-u>TroubleToggle lsp_workspace_diagnostics<CR>" {:silent true})
(map! [:n] "<leader>xd" ":<C-u>TroubleToggle lsp_document_diagnostics<CR>" {:silent true})
(map! [:n] "<leader>xq" ":<C-u>TroubleToggle quickfix<CR>" {:silent true})
(map! [:n] "<leader>xl" ":<C-u>TroubleToggle loclist<CR>" {:silent true})
(map! [:n] "gR" ":<C-u>TroubleToggle lsp_references<CR>" {:silent true})



