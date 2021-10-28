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
                            {:undone {:enabled false}}}}}
    :core.norg.dirman {:config
                       {:workspaces
                        {:default "~/neorg"}
                        :autodetect true
                        :autochdir true}}
    :core.integrations.telescope {}}})

;; norg
(augroup! init-norg
          (autocmd! :FileType :norg "setl shiftwidth=2")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> <Leader>n :<C-u>Neorg keybind norg core.norg.dirman.new.note<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> [d :<C-u>Neorg keybind norg core.integrations.treesitter.previous.heading<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> ]d :<C-u>Neorg keybind norg core.integrations.treesitter.next.heading<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> K :<C-u>Neorg keybind norg core.norg.esupports.goto_link<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> gd :<C-u>Neorg keybind norg core.norg.esupports.goto_link<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> <Leader>d :<C-u>Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> <Up> :<C-u>Neorg keybind norg core.norg.manoeuvre.item_up<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> <Down> :<C-u>Neorg keybind norg core.norg.manoeuvre.item_down<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer><silent> <Leader>l :<C-u>Neorg keybind norg core.integrations.telescope.insert_link<CR>")
          (autocmd!
            :FileType :norg
            "nnoremap <buffer> <Leader>f :<C-u>Neorg keybind norg core.integrations.telescope.find_linkable<CR>"))
