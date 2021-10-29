(module rc.plugin.neorg
  {autoload {nvim aniseed.nvim
             icon rc.icon
             neorg neorg
             callbacks neorg.callbacks}
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
                            {:undone {:enabled false}}}}}
    :core.norg.dirman {:config
                       {:workspaces
                        {:default "~/works/neorg"}
                        :autodetect true
                        :autochdir true}}
    :core.gtd.base {}
    :core.gtd.queries {}
    :core.gtd.ui {}
    :core.integrations.telescope {}}})

(callbacks.on_event
  :core.keybinds.events.enable_keybinds
  (fn [_ keybinds]
    (keybinds.map_event_to_mode
      :norg
      {:n [[:<Leader>n :core.norg.dirman.new.note]
           [:<Leader>c :core.gtd.base.capture]
           [:<Leader>e :core.gtd.base.edit]
           [:<Leader>v :core.gtd.base.views]
           ["[d" :core.integrations.treesitter.previous.heading]
           ["]d" :core.integrations.treesitter.next.heading]
           [:K :core.norg.esupports.goto_link]
           [:gd :core.norg.esupports.goto_link]
           [:<Leader>d :core.norg.qol.todo_items.todo.task_cycle]
           [:<Up> :core.norg.manoeuvre.item_up]
           [:<Down> :core.norg.manoeuvre.item_down]
           [:<Leader>f :core.integrations.telescope.find_linkable]]
       :i [[:<C-l> :core.integrations.telescope.insert_link]]}
      {:silent true
       :noremap true})))

;; norg
(augroup! init-norg
          (autocmd! :FileType :norg "setl shiftwidth=2"))
