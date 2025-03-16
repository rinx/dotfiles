(local cmp (require :blink.cmp))
(local mini-snippets (require :mini.snippets))

(cmp.setup {:enabled (fn []
                       (let [buftype (vim.api.nvim_buf_get_option 0 :buftype)
                             bufname (vim.api.nvim_buf_get_name 0)]
                         (and (not (= buftype :prompt))
                              (not (~= (bufname:match "org%-roam%-select$") nil)))))
            :keymap {:preset :enter}
            :sources
            {:default [:lsp
                       :path
                       :snippets
                       :buffer
                       :ripgrep
                       :emoji
                       :git
                       :orgmode
                       :avante
                       :copilot]
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
                        :module :orgmode.org.autocompletion.blink
                        :fallbacks [:buffer]}
              :avante {:name :avante
                       :module :blink-cmp-avante}
              :copilot {:name :copilot
                        :module :blink-cmp-copilot
                        :score_offset 100
                        :async true}}}
            :completion
            {:documentation {:auto_show true
                             :auto_show_delay_ms 500}
             :menu {:auto_show (fn [ctx]
                                 (or (~= ctx.mode :cmdline)
                                     (not (vim.tbl_contains
                                            [:/ :?]
                                            (vim.fn.getcmdtype)))))}
             :list {:selection
                    {:preselect (fn [ctx]
                                  (~= ctx.mode :cmdline))
                     :auto_insert (fn [ctx]
                                    (~= ctx.mode :cmdline))}}}
            :cmdline {:keymap {:<C-n> [:select_next :fallback]
                               :<C-p> [:select_prev :fallback]
                               :<CR> [:accept :fallback]}}
            :snippets {:preset :mini_snippets}})

;; snippet
(mini-snippets.setup
  {:snippets [(mini-snippets.gen_loader.from_lang)]
   :mappings {:expand :<C-i>}})
