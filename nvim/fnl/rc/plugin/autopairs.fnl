(import-macros {: augroup!} :rc.macros)

(local autopairs (require :nvim-autopairs))

(autopairs.setup {})

(autopairs.remove_rule)

;; clojure
(fn autopairs-adjust-rules-clojure []
  (autopairs.remove_rule "'"))

(augroup!
  init-autopairs-clojure
  {:events [:FileType]
   :pattern :clojure
   :callback autopairs-adjust-rules-clojure})
