(module rc.plugin.grep
  {autoload {core aniseed.core
             nvim aniseed.nvim}
   require-macros [rc.macros]})

(noremap! [:n] :<Leader>g ":<C-u>Grepper -tool rg<CR>" :silent)
