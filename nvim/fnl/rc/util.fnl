(module rc.util
  {autoload {core aniseed.core
             nvim aniseed.nvim}})

(defn _map [from to]
  (nvim.set_keymap "" from to {}))
(defn nmap [from to]
  (nvim.set_keymap :n from to {}))
(defn imap [from to]
  (nvim.set_keymap :i from to {}))
(defn xmap [from to]
  (nvim.set_keymap :x from to {}))
(defn vmap [from to]
  (nvim.set_keymap :v from to {}))
(defn omap [from to]
  (nvim.set_keymap :o from to {}))
(defn nnoremap [from to]
  (nvim.set_keymap :n from to {:noremap true}))
(defn inoremap [from to]
  (nvim.set_keymap :i from to {:noremap true}))
(defn cnoremap [from to]
  (nvim.set_keymap :c from to {:noremap true}))
(defn vnoremap [from to]
  (nvim.set_keymap :v from to {:noremap true}))
(defn onoremap [from to]
  (nvim.set_keymap :o from to {:noremap true}))

(defn nmap-silent [from to]
  (nvim.set_keymap :n from to {:silent true}))
(defn nnoremap-silent [from to]
  (nvim.set_keymap :n from to {:noremap true
                               :silent true}))
(defn inoremap-silent-expr [from to]
  (nvim.set_keymap :i from to {:noremap true
                               :silent true
                               :expr true}))
(defn xnoremap-silent [from to]
  (nvim.set_keymap :x from to {:noremap true
                               :silent true}))

(defn hi [name opts]
  (let [fg (match (core.get opts :fg)
             res (.. " ctermfg=" res " guifg=" res)
             _ "")
        bg (match (core.get opts :bg)
             res (.. " ctermbg=" res " guibg=" res)
             _ "")
        others (match (core.get opts :others)
                 res (.. " " res)
                 _ "")]
    (-> (.. name fg bg others)
        (nvim.ex.highlight))))

(defn hi-link [from to]
  (nvim.ex.highlight_ :link from to))

(defn loaded? [name]
  "Checks if the plugin is loaded."
  (let [plugins (core.get _G :packer_plugins)]
    (when name
      (let [plugin (core.get plugins name)]
        (when plugin
          (core.get plugin :loaded))))))

(defn headless? []
  (core.empty? (nvim.list_uis)))
