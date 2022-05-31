(module rc.plugin.treesitter
  {autoload {configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}})

(let [parser-configs (parsers.get_parser_configs)]
  (set parser-configs.cue
       {:install_info
        {:url "https://github.com/eonpatapon/tree-sitter-cue"
         :files [:src/parser.c :src/scanner.c]
         :branch :main}
        :filetype :cue})
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
   :cue
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

;; dirty hack
(let [queries-dir (string.format :%s/queries (vim.fn.stdpath :config))
      cue-dir (string.format :%s/cue queries-dir)
      cue-highlight-scm (string.format :%s/highlights.scm cue-dir)]
  (when (= (vim.fn.empty (vim.fn.glob cue-highlight-scm)) 1)
    (vim.cmd (string.format "silent !mkdir -p %s" cue-dir))
    (vim.cmd (string.format
               "silent !wget -O %s %s"
               cue-highlight-scm
               "https://raw.githubusercontent.com/eonpatapon/tree-sitter-cue/main/queries/highlights.scm"))))
