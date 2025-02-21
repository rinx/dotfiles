(local cmp (require :blink.cmp))
(local mini-snippets (require :mini.snippets))

(cmp.setup {:keymap {:preset :default}
            :sources
            {:default [:lsp :path :snippets :buffer]}
            :snippets {:preset :mini_snippets}})

;; snippet
(mini-snippets.setup
  {:snippets [(mini-snippets.gen_loader.from_lang)]
   :mappings {:expand :<C-i>}})
