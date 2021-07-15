(module rc.plugin.minimap
  {autoload {nvim aniseed.nvim
             util rc.util}})

(def- nnoremap-silent util.nnoremap-silent)

(set nvim.g.minimap#window#height 40)
(nnoremap-silent "<leader>m" ":<C-u>MinimapToggle<CR>")
