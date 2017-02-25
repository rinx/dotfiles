if &compatible
    set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

set ruler
set number
set cursorline
set cmdheight=2

syntax on

filetype plugin indent on

set autoindent
set smartindent

set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4

if has('vim_starting')
    set runtimepath+=~/.vim/dein/repos/github.com/itchyny/lightline.vim
    set runtimepath+=~/.vim/dein/repos/github.com/tyru/skk.vim
    set runtimepath+=~/.vim/dein/repos/github.com/w0ng/vim-hybrid
endif

let g:skk_jisyo = '~/.skk-jisyo'

if has('mac')
    let g:skk_large_jisyo = '/Library/Dictionaries/SKK/SKK-JISYO.LL'
elseif has('unix')
    let g:skk_large_jisyo = '/usr/share/skk/SKK-JISYO.LL'
endif

let g:skk_auto_save_jisyo = 1
let g:skk_keep_state = 1
let g:skk_egg_like_newline = 1
let g:skk_show_annotation = 1
let g:skk_use_face = 1
let g:skk_marker_white = '>'
let g:skk_marker_black = '>>'
let g:skk_use_color_cursor = 1
let g:skk_cursor_hira_color = '#ff0000'
let g:skk_cursor_kata_color = '#00ff00'
let g:skk_cursor_zenei_color = '#ffcc00'
let g:skk_cursor_ascii_color = '#ffffff'
let g:skk_cursor_addrev_color = '#0000ff'
let g:skk_sticky_key = ';'
let g:skk_imdisable_state = 1
let g:skk_ascii_mode_string =  'aA'
let g:skk_hira_mode_string  =  'あ'
let g:skk_kata_mode_string  =  'ア'
let g:skk_zenei_mode_string =  'Ａ'
let g:skk_abbrev_mode_string = 'aあ'
let g:skk_kutouten_type = "en"
let g:skk_kutouten_jp = "。、"
let g:skk_kutouten_en = "．，"

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g$ $

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" --- Color settings ---

syntax enable
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
set background=dark
colorscheme hybrid

hi Normal ctermbg=none

set laststatus=2

let g:lightline = {
            \ 'active': {
            \   'left': [ 
            \             [ 'mode', 'paste' ],
            \             [ 'fugitive', 'filename' ],
            \   ],
            \   'right': [
            \             [ 'lineinfo' ],
            \             [ 'percent' ],
            \             [ 'skkstatus', 'anzu', 'fileformat', 'fileencoding', 'filetype' ],
            \   ],
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'mode': 'MyMode',
            \   'skkstatus': 'MySkkgetmode',
            \   'anzu': 'anzu#search_status',
            \   'tablineabspath': 'MyAbsPath',
            \   'tabfugitive': 'MyFugitiveInv',
            \ },
            \ 'component_expand': {
            \ },
            \ 'component_type': {
            \ },
            \ 'inactive' : {
            \   'left' : [
            \     [ 'filename' ],
            \   ],
            \   'right' : [
            \     [ 'lineinfo' ],
            \   ],
            \ },
            \ 'tabline' : {
            \   'left' : [
            \     [ 'tabs' ],
            \   ],
            \   'right' : [
            \     [ 'tablineabspath', 'tabfugitive' ],
            \   ],
            \ },
            \ }

function! MyModified()
    return &ft =~ 'help\|qf' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|qf' && &ro ? ' ' : ''
endfunction

function! MyFugitive()
    try
        if exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') > 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFugitiveInv()
    try
        if exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') < 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return &ft == 'qf' ? '' :
                \ winwidth('.') > 60 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'qf' ? 'QuickFix' :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MySkkgetmode()
    let _ = SkkGetModeStr()
    "let _ = eskk#get_mode()
    return winwidth('.') > 70 ? strlen(_) ? substitute(_, '\[\|\]', '', 'g') : '' : ''
endfunction

function! MyAbsPath()
    let _ = expand('%:p:h')
    return &ft == 'qf' ? '' :
                \ tabpagenr('$') < 4 ? _ : ''
endfunction

