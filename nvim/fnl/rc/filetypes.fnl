(module rc.filetypes
  {autoload {nvim aniseed.nvim
             util aniseed.nvim.util}
   require-macros [rc.macros]})

(defn- bridge [from to]
  (util.fn-bridge from :rc.filetypes to {:return true}))

(defn lsp-formatting []
  (let [(ok? val-or-err) (pcall vim.lsp.buf.formatting_seq_sync)]
    (if ok?
      (vim.notify
        "formatted."
        vim.lsp.log_levels.INFO
        {:title :lsp-formatting})
      (vim.notify
        (.. "error occurred: " val-or-err)
        vim.lsp.log_levels.WARN
        {:title :lsp-formatting}))))

;; markdown
(set nvim.g.mkdp_open_to_the_world 1)
(set nvim.g.mkdp_open_ip "0.0.0.0")
(set nvim.g.mkdp_port "8000")
(defn mkdp-echo-url [url]
  (vim.notify
    (.. "preview started: '" url "'")
    vim.lsp.log_levels.INFO
    {:title :markdown-preview}))
(bridge :MkdpEchoURL :mkdp-echo-url)
(set nvim.g.mkdp_browserfunc :MkdpEchoURL)

(augroup! init-markdown
          (autocmd! :FileType :markdown "setl shiftwidth=4"))

;; filetypes
(augroup! init-filetype-detect
          (autocmd! "BufNewFile,BufRead" "*.nml" "setf fortran")
          (autocmd! "BufNewFile,BufRead" "*.namelist" "setf fortran")
          (autocmd! "BufNewFile,BufRead" "*.hy" "setf hy")
          (autocmd! "BufNewFile,BufRead" "*.jl" "setf julia"))

(augroup! init-git-files
          (autocmd! :FileType "gitcommit,gitrebase" "set bufhidden=delete"))

;; hy
(set nvim.g.hy_enable_conceal 0)
(set nvim.g.hy_conceal_fancy 0)
(set nvim.g.conjure#client#hy#stdio#command "hy --repl-output-fn=hy.core.hy-repr.hy-repr")

;; json
(augroup! init-json
          (autocmd! :FileType :json "setl shiftwidth=2"))

;; julia
(augroup! init-julia
          (autocmd! :FileType :julia "setl shiftwidth=4"))

;; yaml
(augroup! init-yaml
          (autocmd! :FileType :yaml "setl shiftwidth=2"))

;; fennel
(set nvim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed.")
(defn conjure-client-fennel-stdio []
  (set nvim.g.conjure#filetype#fennel "conjure.client.fennel.stdio"))
(nvim.ex.command_ :ConjureClientFennelStdio (->viml! :conjure-client-fennel-stdio))

(augroup! init-fennel
          (autocmd! :FileType :fennel "setl shiftwidth=2")
          (autocmd! :FileType :fennel "setl colorcolumn=80"))

;; lua
(augroup! init-lua
          (autocmd! :FileType :lua "setl shiftwidth=2"))

;; clojure
(augroup! init-clojure
          (autocmd! :FileType :clojure "setl colorcolumn=80")
          (autocmd! :BufWritePre "*.clj,*.cljc,*.cljs" (->viml! :lsp-formatting)))

;; go
(augroup! init-golang
          (autocmd! :FileType :go "setl colorcolumn=80")
          (autocmd! :FileType :go "setl noexpandtab")
          (autocmd! :FileType :go "setl shiftwidth=4")
          (autocmd! :FileType :go "setl tabstop=4")
          (autocmd! :FileType :go "setl softtabstop=4")
          (autocmd! :FileType :go "compiler go")
          (autocmd! :BufWritePre "*.go" (->viml! :lsp-formatting)))

;; rust
(augroup! init-rust
          (autocmd! :BufWritePre "*.rs" (->viml! :lsp-formatting)))

;; kotlin
(augroup! init-kotlin
          (autocmd! :BufWritePre "*.kt,*.kts" (->viml! :lsp-formatting)))

;; typescript
(augroup! init-typescript
          (autocmd! :BufWritePre "*.ts" (->viml! :lsp-formatting)))

;; QuickFix
(augroup! init-qf
          (autocmd! :FileType :qf "nnoremap <buffer> j j")
          (autocmd! :FileType :qf "nnoremap <buffer> k k")
          (autocmd! :FileType :qf "nnoremap <buffer> 0 0")
          (autocmd! :FileType :qf "nnoremap <buffer> $ $")
          (autocmd! :FileType :qf "nnoremap <buffer> gj gj")
          (autocmd! :FileType :qf "nnoremap <buffer> gk gk")
          (autocmd! :FileType :qf "nnoremap <buffer> g0 g0")
          (autocmd! :FileType :qf "nnoremap <buffer> g$ g$")
          (autocmd! :FileType :qf "nnoremap <buffer><silent>q :<C-u>q<CR>")
          (autocmd! :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif"))

;; Help
(augroup! init-help
          (autocmd! :FileType :help "nnoremap <buffer> j j")
          (autocmd! :FileType :help "nnoremap <buffer> k k")
          (autocmd! :FileType :help "nnoremap <buffer> 0 0")
          (autocmd! :FileType :help "nnoremap <buffer> $ $")
          (autocmd! :FileType :help "nnoremap <buffer> gj gj")
          (autocmd! :FileType :help "nnoremap <buffer> gk gk")
          (autocmd! :FileType :help "nnoremap <buffer> g0 g0")
          (autocmd! :FileType :help "nnoremap <buffer> g$ g$")
          (autocmd! :FileType :help "nnoremap <buffer><silent>q :<C-u>q<CR>")
          (autocmd! :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'help' | q | endif"))
