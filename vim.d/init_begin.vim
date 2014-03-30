"The beginning of initialization

"encoding

set encoding=utf-8
scriptencoding utf-8

set fileencodings=ucs-bom,utf-8,cp932,sjis


"define functions

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" --- for tabline

" Set tabline.
function! s:my_tabline()
  let s = ''

  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

    " Use gettabvar().
    let title = fnamemodify(bufname(bufnr), ':t')

    let title = '[' . title . ']'

    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor

  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

