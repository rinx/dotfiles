(module dotfiles.plugin.gitsigns
  {autoload {icon dotfiles.icon
             gitsigns gitsigns}})

(def- icontab icon.tab)

(gitsigns.setup
  {:signs {:add {:hl :GitSignsAdd
                 :text icontab.plus
                 :numhl :GitSignsAddNr
                 :linehl :GitSignsAddLn}
           :change {:hl :GitSignsChange
                    :text icontab.circle
                    :numhl :GitSignsChangeNr
                    :linehl :GitSignsChangeLn}
           :delete {:hl :GitSignsDelete
                    :text icontab.minus
                    :numhl :GitSignsDeleteNr
                    :linehl :GitSignsDeleteLn}
           :topdelete {:hl :GitSignsDelete
                       :text icontab.level-up
                       :numhl :GitSignsDeleteNr
                       :linehl :GitSignsDeleteLn}
           :changedelete {:hl :GitSignsChange
                          :text icontab.dots
                          :numhl :GitSignsChangeNr
                          :linehl :GitSignsChangeLn}}
   :numhl false
   :linehl false
   :keymaps {}
   :watch_index {:interval 1000}
   :current_line_blame false
   :sign_priority 6
   :update_debounce 100
   :status_formatter nil
   :use_decoration_api true
   :use_internal_diff true})
