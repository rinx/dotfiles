(module rc.plugin.treesitter
  {autoload {configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(let [parser-configs (parsers.get_parser_configs)]
  (set parser-configs.markdown
       {:install_info
        {:url "https://github.com/MDeiml/tree-sitter-markdown"
         :files [:src/parser.c :src/scanner.cc]
         :branch :main}})
  (set parser-configs.norg
       {:install_info
        {:url "https://github.com/nvim-neorg/tree-sitter-norg"
         :files [:src/parser.c :src/scanner.cc]
         :branch :main}})
  (set parser-configs.norg_meta
       {:install_info
        {:url "https://github.com/nvim-neorg/tree-sitter-norg-meta"
         :files [:src/parser.c]
         :branch :main}})
  (set parser-configs.norg_table
       {:install_info
        {:url "https://github.com/nvim-neorg/tree-sitter-norg-table"
         :files [:src/parser.c]
         :branch :main}}))

(configs.setup
  {:ensure_installed [:markdown
                      :norg
                      :norg_meta
                      :norg_table]})

(configs.setup
  {:ensure_installed :maintained
   :highlight {:enable true
               :disable []}
   :indent {:enable true
            :disable []}
   :context_commentstring {:enable true
                           :enable_autocmd false}})
