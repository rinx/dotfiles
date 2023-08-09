(local {: autoload} (require :nfnl.module))

(local tdc (require :todo-comments))

(local color (autoload :rc.color))
(local icon (autoload :rc.icon))

(local colors color.colors)
(local icontab icon.tab)

(tdc.setup {:signs true
            :keywords {:FIX {:icon icontab.bug
                             :color :error
                             :alt [:FIXME :BUG :FIXIT :FIX :ISSUE]}
                       :TODO {:icon icontab.check
                              :color :info}
                       :HACK {:icon icontab.fire
                              :color :warning}
                       :WARN {:icon icontab.excram-tri
                              :color :warning}
                       :PERF {:icon icontab.watch
                              :color :default
                              :alt [:OPTIM :PERFORMANCE :OPTIMIZE]}
                       :NOTE {:icon icontab.comment-alt
                              :color :hint
                              :alt [:INFO]}}
            :colors {:error [:DiagnosticSignError]
                     :warning [:DiagnosticSignWarn]
                     :info [:DiagnosticSignInfo]
                     :hint [:DiagnosticSignHint]
                     :default [colors.purple]}})
