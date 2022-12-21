(module rc.plugin.comment
  {autoload {cm Comment
             ts-commentstring ts_context_commentstring.internal}})

(defn hook-fn []
  (fn [ctx]
    (ts-commentstring.calculate_commentstring)))

(cm.setup
  {:pre_hook (hook-fn)})
