(module rc.plugin.toggleterm
  {autoload {util rc.util
             toggleterm toggleterm}})

(def- nnoremap-silent util.nnoremap-silent)

(toggleterm.setup {})

(nnoremap-silent :<leader>w ":<C-u>ToggleTerm<CR>")
