(module rc.plugin.neorg
  {autoload {nvim aniseed.nvim
             icon rc.icon
             neorg neorg}
   require-macros [rc.macros]})

(def- icontab icon.tab)

(neorg.setup
  {:load
   {:core.defaults {}
    :core.norg.completion {:config
                           {:engine :nvim-cmp}}
    :core.norg.concealer {:config
                          {:icons
                           {:heading
                            {:level_1 {:icon icontab.number-1-mult}
                             :level_2 {:icon (.. " " icontab.number-2-mult)}
                             :level_3 {:icon (.. "  " icontab.number-3-mult)}
                             :level_4 {:icon (.. "   " icontab.number-4-mult)}
                             :level_5 {:icon (.. "    " icontab.number-5-mult)}
                             :level_6 {:icon (.. "     " icontab.number-6-mult)}}
                            :todo
                            {:done {:icon ""}
                             :undone {:enabled false}}}}}
    :core.norg.dirman {:config
                       {:workspaces
                        {:default "~/neorg"}
                        :autodetect true
                        :autochdir true}}
    :core.integrations.telescope {}}})

;; norg
(augroup! init-norg
          (autocmd! :FileType :norg "setl shiftwidth=2"))
