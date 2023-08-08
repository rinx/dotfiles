(local cm (require :Comment))
(local ts-commentstring (require :ts_context_commentstring.internal))

(cm.setup
  {:pre_hook (fn [ctx]
               (ts-commentstring.calculate_commentstring))})
