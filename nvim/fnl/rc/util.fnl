(module rc.util
  {autoload {core aniseed.core
             nvim aniseed.nvim}})

(defn _map [from to]
  (nvim.set_keymap "" from to {}))

(defn loaded? [name]
  "Checks if the plugin is loaded."
  (let [plugins (core.get _G :packer_plugins)]
    (when name
      (let [plugin (core.get plugins name)]
        (when plugin
          (core.get plugin :loaded))))))

(defn headless? []
  (core.empty? (nvim.list_uis)))
