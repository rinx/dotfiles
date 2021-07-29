(module rc.plugin.compe
  {autoload {icon rc.icon
             util rc.util
             compe compe}})

(def- icontab icon.tab)
(def- inoremap-silent-expr util.inoremap-silent-expr)

(compe.setup
  {:enabled true
   :autocomplete true
   :debug false
   :min_length 1
   :preselect :enable
   :throttle_time 80
   :source_timeout 200
   :incomplete_delay 400
   :max_abbr_width 100
   :max_kind_width 100
   :max_menu_width 100
   :documentation true
   :source {:buffer {:kind icontab.document}
            :calc {:kind icontab.calc}
            :conjure {:filetypes [:clojure
                                  :fennel
                                  :hy]}
            :emoji {:kind icontab.heart
                    :filetypes [:gitcommit
                                :markdown]}
            :nvim_lsp {:kind icontab.cube}
            :nvim_lua {:kind icontab.vim
                       :filetypes [:lua]}
            :omni false
            :path {:kind icontab.dots}
            :spell {:kind icontab.pencil}
            :tag {:kind icontab.tag}
            :treesitter {:kind icontab.leaf}
            :vsnip {:kind icontab.quote-l}}})

(inoremap-silent-expr :<C-s>  "compe#complete()")
(inoremap-silent-expr :<C-e>  "compe#close('<C-e>')")
(inoremap-silent-expr :<Up>   "compe#scroll({ 'delta': +4 })")
(inoremap-silent-expr :<Down> "compe#scroll({ 'delta': -4 })")
