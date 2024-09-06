(import-macros {: augroup!} :rc.macros)

(augroup!
  init-filetype-detect
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.cue"
   :command "setf cue"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.nml,*.namelist"
   :command "setf fortran"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.jq"
   :command "setf jq"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.jl"
   :command "setf julia"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.rego,*.rq"
   :command "setf rego"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.tf,*.tfvars"
   :command "setf terraform"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern ".github/workflows/*.yaml,.github/workflows/*.yml"
   :command "setf yaml.github-actions"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "docker-compose.yaml"
   :command "setf yaml.docker-compose"})

(augroup!
  init-git-files
  {:events [:FileType]
   :pattern "gitcommit,gitrebase"
   :command "set bufhidden=delete"})

(augroup!
  init-markdown
  {:events [:FileType]
   :pattern :markdown
   :command "setl shiftwidth=4"})

(augroup!
  init-nix
  {:events [:FileType]
   :pattern :nix
   :command "setl shiftwidth=2"})

(augroup!
  init-json
  {:events [:FileType]
   :pattern :json
   :command "setl shiftwidth=2"})

(augroup!
  init-julia
  {:events [:FileType]
   :pattern :julia
   :command "setl shiftwidth=4"})

(augroup!
  init-yaml
  {:events [:FileType]
   :pattern :yaml
   :command "setl shiftwidth=2"})

(augroup!
  init-yaml
  {:events [:FileType]
   :pattern :yaml
   :command "setl shiftwidth=2"})

(augroup!
  init-fennel
  {:events [:FileType]
   :pattern :fennel
   :command "setl shiftwidth=2"}
  {:events [:FileType]
   :pattern :fennel
   :command "setl colorcolumn=80"})

(augroup!
  init-lua
  {:events [:FileType]
   :pattern :lua
   :command "setl shiftwidth=2"})

(augroup!
  init-clojure
  {:events [:FileType]
   :pattern :clojure
   :command "nnoremap <buffer><silent> <leader>K :<C-u>lua vim.lsp.buf.hover()<CR>"}
  {:events [:FileType]
   :pattern :clojure
   :command "setl colorcolumn=80"})

(augroup!
  init-go
  {:events [:FileType]
   :pattern :go
   :command "setl colorcolumn=80"}
  {:events [:FileType]
   :pattern :go
   :command "setl noexpandtab"}
  {:events [:FileType]
   :pattern :go
   :command "setl shiftwidth=4"}
  {:events [:FileType]
   :pattern :go
   :command "setl tabstop=4"}
  {:events [:FileType]
   :pattern :go
   :command "setl softtabstop=4"}
  {:events [:FileType]
   :pattern :go
   :command "compiler go"})

(augroup!
  init-rego
  {:events [:FileType]
   :pattern :rego
   :command "setl colorcolumn=120"}
  {:events [:FileType]
   :pattern :rego
   :command "setl noexpandtab"}
  {:events [:FileType]
   :pattern :rego
   :command "setl shiftwidth=4"}
  {:events [:FileType]
   :pattern :rego
   :command "setl tabstop=4"}
  {:events [:FileType]
   :pattern :rego
   :command "setl softtabstop=4"})

(augroup!
  init-terraform
  {:events [:FileType]
   :pattern :terraform
   :command "setl shiftwidth=2"})

(augroup!
  init-typescript
  {:events [:FileType]
   :pattern :typescript
   :command "setl shiftwidth=2"})

(augroup!
  init-qf
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> j j"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> k k"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> 0 0"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> $ $"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> gj gj"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> gk gk"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> g0 g0"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer> g$ g$"}
  {:events [:FileType]
   :pattern :qf
   :command "nnoremap <buffer><silent>q :<C-u>q<CR>"}
  {:events [:WinEnter]
   :pattern :*
   :command "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif"})

(augroup!
  init-help
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> j j"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> k k"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> 0 0"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> $ $"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> gj gj"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> gk gk"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> g0 g0"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer> g$ g$"}
  {:events [:FileType]
   :pattern :help
   :command "nnoremap <buffer><silent>q :<C-u>q<CR>"}
  {:events [:WinEnter]
   :pattern :*
   :command "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif"})
