(module rc.plugin.comment
  {autoload {util rc.util
             cm Comment}})

(def- loaded? util.loaded?)

(defn hook-fn []
  (when (loaded? :nvim-ts-context-commentstring)
    (let [ts-commentstring (require :ts_context_commentstring.internal)]
      (fn [ctx]
        (ts-commentstring.calculate_commentstring)))))

(cm.setup
  {:pre_hook (hook-fn)})
