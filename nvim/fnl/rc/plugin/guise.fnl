(module rc.plugin.guise
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util rc.util}
   require-macros [rc.macros]})

(set nvim.g.guise_edit_opener :vsp)
