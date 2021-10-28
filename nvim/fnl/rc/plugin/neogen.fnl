(module rc.plugin.neogen
  {autoload {core aniseed.core
             nvim aniseed.nvim
             neogen neogen}
   require-macros [rc.macros]})

(neogen.setup
  {:enabled true})

(noremap! [:n]
          :<Leader>n
          ":<C-u>lua require('neogen').generate()<CR>"
          :silent)
