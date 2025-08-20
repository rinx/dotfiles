(local ts (require :nvim-treesitter))

(import-macros {: augroup!} :rc.macros)

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
   :tmux
   :toml
   :tsx
   :typescript
   :typst
   :vim
   :vimdoc
   :vrl
   :vue
   :xml
   :yaml
   :zig])

(ts.setup {})
(ts.install languages)

(augroup!
  init-treesitter
  {:events [:FileType]
   :callback (fn [ctx]
               (pcall vim.treesitter.start)
               (set vim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()")
               (when (= vim.bo.indentexpr "")
                 (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")))})

(fn ensure-installed []
  (let [installer (ts.install languages)]
    (installer:wait 300000)))
(vim.api.nvim_create_user_command :TSInstallEnsure ensure-installed {})
