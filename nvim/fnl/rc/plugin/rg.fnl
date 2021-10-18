(module rc.plugin.rg
  {autoload {core aniseed.core
             nvim aniseed.nvim
             color rc.color
             rg nvim-ripgrep
             ex nvim-ripgrep.extensions}
   require-macros [rc.macros]})

(def- colors color.colors)

(rg.setup
  {:prompt " "
   :open_qf_fn ex.trouble_open_qf})

(nvim.ex.command_ :Rg "lua require'nvim-ripgrep'.grep()")
(noremap! [:n] :<Leader>g ":<C-u>Rg<CR>" :silent)

(hi! :RgNormal
     {:bg :none
      :blend :0})
(hi! :RgBorder
     {:bg :none
      :blend :0
      :ctermfg :blue
      :guifg colors.color10})
