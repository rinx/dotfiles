(module rc.plugin.treesitter
  {autoload {nvim aniseed.nvim
             configs nvim-treesitter.configs
             parsers nvim-treesitter.parsers}
   require-macros [rc.macros]})

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
   :diff
   :dockerfile
   :elixir
   :elm
   :erlang
   :fennel
   :fortran
   :git_rebase
   :gitattributes
   :gitcommit
   :gitignore
   :go
   :gomod
   :graphql
   :hcl
   :help
   :hjson
   :html
   :http
   :java
   :javascript
   :jq
   :jsdoc
   :json
   :json5
   :jsonc
   :jsonnet
   :julia
   :kotlin
   :latex
   :llvm
   :lua
   :make
   :markdown
   :mermaid
   :norg
   :norg_meta
   :norg_table
   :passwd
   :proto
   :python
   :ql
   :query
   :r
   :regex
   :rego
   :rst
   :rust
   :scss
   :sparql
   :sql
   :teal
   :terraform
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

(defn ensure-installed []
  (each [_ lang (ipairs languages)]
    (vim.cmd (string.format "TSInstallSync! %s" lang))))
(nvim.ex.command_ :TSInstallEnsure (->viml! :ensure-installed))
