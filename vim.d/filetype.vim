" --- filetype settings ---

"golang
set rtp^=$GOROOT/misc/vim
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim
let g:gofmt_command = 'goimports'
augroup golang
    autocmd!
    autocmd BufWritePre *.go Fmt
    autocmd BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
    autocmd FileType go compiler go
augroup END


" --- below this, they are not filetypes but ...

"QuickFix window
augroup forQuickFix
    autocmd!
    " mappings
    autocmd FileType qf nnoremap <buffer> j j
    autocmd FileType qf nnoremap <buffer> k k
    autocmd FileType qf nnoremap <buffer> 0 0
    autocmd FileType qf nnoremap <buffer> $ $
    autocmd FileType qf nnoremap <buffer> gj gj
    autocmd FileType qf nnoremap <buffer> gk gk
    autocmd FileType qf nnoremap <buffer> g0 g0
    autocmd FileType qf nnoremap <buffer> g$ g$
    " quit QuickFix with q-key
    autocmd FileType qf nnoremap <buffer><silent>q :<C-u>q<CR>
    " autoclose
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif
augroup END

