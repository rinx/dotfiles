(module rc.plugin.autopairs
  {autoload {core aniseed.core
             nvim aniseed.nvim
             autopairs nvim-autopairs
             rule nvim-autopairs.rule}
   require-macros [rc.macros]})

(autopairs.setup {})

(autopairs.remove_rule)

;; clojure
(defn autopairs-adjust-rules-clojure []
  (autopairs.remove_rule "'"))
(augroup! init-autopairs-clojure
          (autocmd! :FileType :clojure
                    (->viml! :autopairs-adjust-rules-clojure)))
