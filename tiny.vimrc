set nocompatible

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
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

call dein#begin(expand('~/.vim/dein/'))

call dein#add('Shougo/dein.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('tyru/skk.vim')
call dein#add('tomasr/molokai')

call dein#end()

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
if !exists('g:colors_name')
    set background=dark
    colorscheme molokai 
endif

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
    return &ft =~ 'help\|vimfiler\|gundo\|nerdtree\|qf\|quickrun' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo\|nerdtree\|qf\|quickrun' && &ro ? ' ' : ''
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') > 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFugitiveInv()
    try
        if &ft !~? 'vimfiler\|gundo\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
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
    return &ft == 'vimfiler' ? 'VimFiler' : 
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ &ft == 'qf' ? '' :
                \ &ft == 'quickrun' ? '' :
                \ winwidth('.') > 60 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
                \  &ft == 'qf' ? 'QuickFix' :
                \  &ft == 'quickrun' ? 'QuickRun' :
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
    return &ft == 'vimfiler' ? '' : 
                \ &ft == 'unite' ? '' :
                \ &ft == 'vimshell' ? '' :
                \ &ft == 'qf' ? '' :
                \ &ft == 'quickrun' ? '' : 
                \ tabpagenr('$') < 4 ? _ : ''
endfunction

