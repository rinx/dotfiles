(module dotfiles.plugin.minimap
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

(def- nnoremap-silent util.nnoremap-silent)

(set nvim.g.minimap#window#height 40)
(nnoremap-silent "<leader>m" ":<C-u>MinimapToggle<CR>")
