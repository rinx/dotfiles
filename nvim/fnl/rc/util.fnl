(module rc.util
  {autoload {core aniseed.core
             nvim aniseed.nvim}})

(defn _map [from to]
  (nvim.set_keymap "" from to {}))

(defn headless? []
  (core.empty? (nvim.list_uis)))
