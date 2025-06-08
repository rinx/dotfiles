(local configs (require :nvim-treesitter.configs))
(local commentstring (require :ts_context_commentstring))

(local languages
  [:bash
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
   :earthfile
   :editorconfig
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
   :gleam
   :go
   :gomod
   :gosum
   :gotmpl
   :gowork
   :gpg
   :graphql
   :hcl
   :helm
   :hjson
   :html
   :http
   :hyprlang
   :ini
   :janet_simple
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
   :markdown_inline
   :mermaid
   :nginx
   :nix
   :passwd
   :pem
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
   :ssh_config
   :strace
   :teal
   :terraform
   :toml
   :tsx
   :typescript
   :vim
   :vimdoc
   :vrl
   :vue
   :xml
   :yaml
   :zig])

(configs.setup
  {:ensure_installed languages
   :highlight {:enable true
               :disable []
               :additional_vim_regex_highlighting [:org]}
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
