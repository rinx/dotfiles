(module rc.plugin.toggleterm
  {autoload {nvim aniseed.nvim
             toggleterm toggleterm}
   require-macros [rc.macros]})

(toggleterm.setup {})

(noremap! [:n] :<leader>w ":<C-u>ToggleTerm<CR>" :silent)
