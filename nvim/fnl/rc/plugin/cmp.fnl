(local cmp (require :blink.cmp))
(local mini-snippets (require :mini.snippets))

(cmp.setup {:enabled (fn []
                       (let [buftype (vim.api.nvim_buf_get_option 0 :buftype)
                             bufname (vim.api.nvim_buf_get_name 0)]
                         (and (not (= buftype :prompt))
                              (not (~= (bufname:match "org%-roam%-select$") nil)))))
            :keymap {:preset :default}
            :sources
            {:default [:lsp
                       :path
                       :snippets
                       :buffer
                       :ripgrep
                       :emoji
                       :git
                       :orgmode]
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
                                 vim.bo.filetype))}
              :orgmode {:name :orgmode
                        :module :blink.compat.source}}}
            :snippets {:preset :mini_snippets}})

;; snippet
(mini-snippets.setup
  {:snippets [(mini-snippets.gen_loader.from_lang)]
   :mappings {:expand :<C-i>}})
