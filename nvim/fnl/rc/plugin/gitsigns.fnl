(local {: autoload} (require :nfnl.module))

(local gitsigns (require :gitsigns))

(local icon (autoload :rc.icon))

(local icontab icon.tab)

(gitsigns.setup
  {:signs {:add {:text icontab.plus}
           :change {:text icontab.circle}
           :delete {:text icontab.minus}
           :topdelete {:text icontab.level-up}
           :changedelete {:text icontab.dots}
           :untracked {:text icontab.nbsp}}
   :signs_staged {:add {:text icontab.plus}
                  :change {:text icontab.circle}
                  :delete {:text icontab.minus}
                  :topdelete {:text icontab.level-up}
                  :changedelete {:text icontab.dots}
                  :untracked {:text icontab.nbsp}}
   :signs_staged_enable true
   :numhl false
   :linehl false
   :word_diff true
   :watch_gitdir {:follow_files true}
   :current_line_blame false
   :sign_priority 6
   :update_debounce 100
   :status_formatter nil})
