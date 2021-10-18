(module rc.plugin.rg
  {autoload {core aniseed.core
             nvim aniseed.nvim
             rg nvim-ripgrep
             ex nvim-ripgrep.extensions}
   require-macros [rc.macros]})

(rg.setup
  {:prompt " "
   :open_qf_fn ex.trouble_open_qf})

(nvim.ex.command_ :Rg "lua require'nvim-ripgrep'.grep()")
(noremap! [:n] :<Leader>g ":<C-u>Rg<CR>" :silent)
