(module rc.plugin.treesitter
  {autoload {configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(let [parser-configs (parsers.get_parser_configs)]
  (set parser-configs.norg
       {:install_info
        {:url "https://github.com/nvim-neorg/tree-sitter-norg"
         :files [:src/parser.c :src/scanner.cc]
         :branch :main}}))

(configs.setup {:ensure_installed [:norg]})

(configs.setup
  {:ensure_installed :maintained
   :highlight {:enable true
               :disable []}
   :indent {:enable true
            :disable []}
   :context_commentstring {:enable true
                           :enable_autocmd false}})
