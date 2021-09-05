(module rc.plugin.notify
  {autoload {nvim aniseed.nvim
             color rc.color
             icon rc.icon
             notify notify}})

(def- icontab icon.tab)

(notify.setup
  {:stages :fade_in_slide_out
   :timeout 5000
   :icons {:ERROR icontab.ban
           :WARN icontab.exclam-tri
           :INFO icontab.info-circle
           :DEBUG icontab.bug
           :TRACE icontab.bug}})

(set vim.notify notify)
