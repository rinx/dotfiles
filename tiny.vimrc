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
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tyru/skk.vim'

if neobundle#tap('skk.vim')
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

    call neobundle#untap()
endif

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

"Color
if filereadable(expand('~/.dotfiles/vim.d/color.vim'))
    source ~/.dotfiles/vim.d/color.vim
endif

"Statusline
if filereadable(expand('~/.dotfiles/vim.d/statusline.vim'))
    source ~/.dotfiles/vim.d/statusline.vim
endif


