(module rc.plugin.treesitter
  {autoload {configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(let [parser-configs (parsers.get_parser_configs)]
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

(def- languages
  [:bash
   :bibtex
   :c
   :clojure
   :cmake
   :comment
   :commonlisp
   :cpp
   :css
   :dockerfile
   :elixir
   :elm
   :erlang
   :fennel
   :fortran
   :go
   :gomod
   :graphql
   :hcl
   :hjson
   :html
   :http
   :java
   :javascript
   :jsdoc
   :json
   :json5
   :jsonc
   :julia
   :kotlin
   :latex
   :llvm
   :lua
   :make
   :markdown
   :norg
   :norg_meta
   :norg_table
   :python
   :ql
   :query
   :r
   :regex
   :rst
   :rust
   :scss
   :sparql
   :tlaplus
   :toml
   :tsx
   :typescript
   :vim
   :vue
   :yaml])

(configs.setup
  {:ensure_installed languages
   :highlight {:enable true
               :disable []}
   :indent {:enable true
            :disable []}
   :context_commentstring {:enable true
                           :enable_autocmd false}})
