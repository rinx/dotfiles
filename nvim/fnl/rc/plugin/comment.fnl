(module rc.plugin.comment
  {autoload {util rc.util
             ncm nvim_comment}})

(def- loaded? util.loaded?)

(defn hook-fn []
  (when (loaded? :nvim-ts-context-commentstring)
    (let [ts-commentstring (require :ts_context_commentstring.internal)]
      (fn []
        (ts-commentstring.update_commentstring)))))

(ncm.setup
  {:marker_padding true
   :comment_empty true
   :create_mappings true
   :line_mapping :gcc
   :operator_mapping :gc
   :hook (hook-fn)})
