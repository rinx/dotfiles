(local configs (require :nvim-treesitter.configs))
(local commentstring (require :ts_context_commentstring))

(local languages
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
   :dot
   :elixir
   :elm
   :erlang
   :fennel
   :fortran
   :git_config
   :git_rebase
   :gitattributes
   :gitcommit
   :gitignore
   :go
   :gomod
   :gosum
   :gowork
   :graphql
   :hcl
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
   :luadoc
   :luap
   :make
   :markdown
   :mermaid
   :norg
   :passwd
   :promql
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
   :smithy
   :sparql
   :sql
   :teal
   :terraform
   :toml
   :tsx
   :typescript
   :vim
   :vimdoc
   :vue
   :yaml])

(configs.setup
  {:ensure_installed languages
   :highlight {:enable true
               :disable []}
   :indent {:enable true
            :disable []}})

;; context-commentstring
(set vim.g.skip_ts_context_commentstring_module true)
(commentstring.setup
  {:enable_autocmd false})

(fn ensure-installed []
  (each [_ lang (ipairs languages)]
    (vim.cmd (string.format "TSInstallSync! %s" lang))))
(vim.api.nvim_create_user_command :TSInstallEnsure ensure-installed {})
