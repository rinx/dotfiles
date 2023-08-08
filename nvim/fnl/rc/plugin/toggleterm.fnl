(local toggleterm (require :toggleterm))

(import-macros {: map!} :rc.macros)

(toggleterm.setup {})

(map! [:n] :<leader>w ":<C-u>ToggleTerm<CR>" {:silent true})
