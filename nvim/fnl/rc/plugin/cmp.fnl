(local cmp (require :blink.cmp))
(local mini-snippets (require :mini.snippets))

(cmp.setup {:keymap {:preset :default}
            :sources
            {:default [:lsp
                       :path
                       :snippets
                       :buffer
                       :ripgrep
                       :emoji
                       :git]
             :providers
             {:ripgrep {:module :blink-ripgrep
                        :name :Ripgrep}
              :emoji {:module :blink-emoji
                      :name :Emoji
                      :score_offset 15
                      :opts {:insert true}
                      :should_show_items (fn []
                                           (vim.tbl_contains
                                             [:gitcommit
                                              :markdown]
                                             vim.bo.filetype))}
              :git {:module :blink-cmp-git
                    :name :Git
                    :enabled (fn []
                               (vim.tbl_contains
                                 [:octo
                                  :gitcommit
                                  :markdown]
                                 vim.bo.filetype))}}}
            :snippets {:preset :mini_snippets}})

;; snippet
(mini-snippets.setup
  {:snippets [(mini-snippets.gen_loader.from_lang)]
   :mappings {:expand :<C-i>}})
