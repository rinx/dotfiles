(module rc.plugin.treesitter
  {autoload {configs nvim-treesitter.configs}})

(configs.setup
  {:ensure_installed :maintained
   :highlight {:enable true
               :disable []}
   :indent {:enable true
            :disable []}
   :context_commentstring {:enable true
                           :enable_autocmd false}})
