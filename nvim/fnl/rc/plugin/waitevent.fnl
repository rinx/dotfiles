(set vim.env.GIT_EDITOR
     (let [waitevent (require :waitevent)]
       (waitevent.editor
         {:open (fn [ctx path]
                  (vim.cmd.vsplit path)
                  (ctx.lcd)
                  (set vim.bo.bufhidden :wipe))})))

(set vim.env.EDITOR
     (let [waitevent (require :waitevent)]
       (waitevent.editor
         {:done_events []
          :cancel_events []})))
