(local {: autoload} (require :nfnl.module))

(local core (autoload :nfnl.core))

(import-macros {: augroup!} :rc.macros)

(fn lsp-formatting []
  (let [(ok? val-or-err) (pcall vim.lsp.buf.format)]
    (if ok?
      (vim.notify
        "formatted."
        vim.lsp.log_levels.INFO
        {:title :lsp-formatting})
      (vim.notify
        (.. "error occurred: " val-or-err)
        vim.lsp.log_levels.WARN
        {:title :lsp-formatting}))))

; (augroup!
;   init-filetype-detect
;   (autocmd! [:BufNewFile :BufRead :BufWinEnter] "*.cue" "setf cue")
;   (autocmd! [:BufNewFile :BufRead :BufWinEnter] "*.nml,*.namelist" "setf fortran")
;   (autocmd! [:BufNewFile :BufRead :BufWinEnter] "*.jl" "setf julia")
;   (autocmd! [:BufNewFile :BufRead :BufWinEnter] "*.tf,*.tfvars" "setf terraform"))

(augroup!
  init-filetype-detect
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.cue"
   :command "setf cue"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.nml,*.namelist"
   :command "setf fortran"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.jl"
   :command "setf julia"}
  {:events [:BufNewFile :BufRead :BufWinEnter]
   :pattern "*.tf,*.tfvars"
   :command "setf terraform"})

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
   :command "setl colorcolumn=80"}
  {:events [:BufWritePre]
   :pattern "*.clj,*.cljc,*.cljs"
   :callback lsp-formatting})

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
   :command "compiler go"}
  {:events [:BufWritePre]
   :pattern "*.go"
   :callback lsp-formatting})

(augroup!
  init-rust
  {:events [:BufWritePre]
   :pattern "*.rs"
   :callback lsp-formatting})

(augroup!
  init-kotlin
  {:events [:BufWritePre]
   :pattern "*.kt,*.kts"
   :callback lsp-formatting})

(augroup!
  init-terraform
  {:events [:FileType]
   :pattern :terraform
   :command "setl shiftwidth=2"}
  {:events [:BufWritePre]
   :pattern "*.tf,*.tfvars"
   :callback lsp-formatting})

(augroup!
  init-typescript
  {:events [:FileType]
   :pattern :typescript
   :command "setl shiftwidth=2"}
  {:events [:BufWritePre]
   :pattern "*.ts"
   :callback lsp-formatting})

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

(set vim.g.dps_ghosttext#ftmap
     {:github.com :markdown
      :app.zenhub.com :markdown
      :mail.google.com :html})
