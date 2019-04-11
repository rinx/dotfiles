" ----------------------------------------
" Author: Rintaro Okamura
" Source: https://github.com/rinx/dotfiles
" ----------------------------------------

if &compatible
    set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,sjis

let g:vimrc_private = {}
let s:vimrc_private_filename = '~/.vimrc_private'
if filereadable(expand(s:vimrc_private_filename))
    execute 'source' expand(s:vimrc_private_filename)
else
    call system('touch ' . expand(s:vimrc_private_filename))
endif
unlet s:vimrc_private_filename

if executable('python2')
    let g:python_host_prog = substitute(system('which python2'),"\n","","")
endif
if executable('python3')
    let g:python3_host_prog = substitute(system('which python3'),"\n","","")
endif

let s:plug_dir = '~/.config/nvim/plugged'

let s:plug_repo_dir = s:plug_dir . '/vim-plug'

if !isdirectory(expand(s:plug_repo_dir))
    call mkdir(expand(s:plug_repo_dir), "p")
    call system('git clone https://github.com/junegunn/vim-plug.git ' . expand(s:plug_repo_dir) . '/autoload')
endif

if has('vim_starting')
    execute 'set runtimepath+=' . s:plug_repo_dir
endif

call plug#begin(expand(s:plug_dir))

Plug 'junegunn/vim-plug', {'dir': '~/.config/nvim/plugged/vim-plug/autoload'}

Plug 'itchyny/lightline.vim'

Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

call plug#end()

set viminfo='1000,<100,f1,h,s100
set history=300

set bs=indent,eol,start

set ruler
set number
set cmdheight=2
set wildmenu
set wildchar=<Tab>
set wildmode=longest:full,full

set imdisable

set incsearch
set ignorecase
set smartcase

filetype plugin indent on
set autoindent
set smartindent
set breakindent

set confirm

set clipboard+=unnamed,unnamedplus

set mouse=a

set foldmethod=marker

set virtualedit=block

set expandtab
set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4

if &term=="xterm"
    set t_Co=256
    set t_Sb=[4%dm
    set t_Sf=[3%dm
endif

syntax on
set hlsearch

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set visualbell
set lazyredraw
set ttyfast

set sessionoptions+=tabpages
set sessionoptions-=options

set showmatch
set matchtime=3

set nobackup
set nowritebackup

set updatetime=300

set shortmess+=c

set signcolumn=yes

set undofile
set undolevels=1000
set undoreload=10000

set backupdir=~/.config/lightvim/tmp/backup
set undodir=~/.config/lightvim/tmp/undo
set directory=~/.config/lightvim/tmp/swap

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

set list
set listchars=eol:¬,tab:▸\ ,extends:>,precedes:<,trail:-

set noautochdir
set autoread
set noautowrite

set noexrc
set nosecure

set timeout
set timeoutlen=1000
set ttimeoutlen=200

set hidden

syntax enable

let g:mapleader = '\'

nnoremap <C-r><C-f> :source ~/.vimrc<CR>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

nnoremap <Left> <Nop>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <Right> <Nop>

inoremap <Left> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>

nnoremap <C-t> <Nop>

nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
vnoremap j gj
vnoremap k gk
onoremap j gj
onoremap k gk

nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g$ $
vnoremap gj j
vnoremap gk k
onoremap gj j
onoremap gk k

nnoremap Y y$

nnoremap ,p "+p
nnoremap ,P "+P

nnoremap ,y "+y
nnoremap ,d "+d
vnoremap ,y "+y
vnoremap ,d "+d

cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

nnoremap [Tab] <Nop>
nmap ,t [Tab]
nnoremap [Buf] <Nop>
nmap ,b [Buf]

for s:n in range(1, 9)
    execute 'nnoremap <silent> [Tab]'. s:n ':<C-u>tabnext'. s:n .'<CR>'
    execute 'nnoremap <silent> [Buf]'. s:n ':<C-u>buffer '. s:n .'<CR>'
endfor

nnoremap <silent> [Tab]c :<C-u>tablast <bar> tabnew<CR>
nnoremap <silent> [Tab]x :<C-u>tabclose<CR>
nnoremap <silent> [Tab]n :<C-u>tabnext<CR>
nnoremap <silent> [Tab]p :<C-u>tabprevious<CR>
nnoremap <silent> [Tab]l :<C-u>+tabmove<CR>
nnoremap <silent> [Tab]h :<C-u>-tabmove<CR>

" for terminal
tnoremap <silent> <ESC> <C-\><C-n>

" for window
nnoremap s <Nop>
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l
nnoremap <silent> sh <C-w>h
nnoremap <silent> sJ <C-w>J
nnoremap <silent> sK <C-w>K
nnoremap <silent> sL <C-w>L
nnoremap <silent> sH <C-w>H
nnoremap <silent> sr <C-w>r
nnoremap <silent> sw <C-w>w
nnoremap <silent> s_ <C-w>_
nnoremap <silent> s| <C-w>|
nnoremap <silent> so <C-w>_<C-w>|
nnoremap <silent> sO <C-w>=
nnoremap <silent> s= <C-w>=
nnoremap <silent> ss :<C-u>sp<CR>
nnoremap <silent> sv :<C-u>vs<CR>

" toggle paste mode
nnoremap <silent> <Leader>p :setl paste!<CR>

" toggle relativenumber
nnoremap <silent> <Leader>r :setl relativenumber!<CR>

" toggle spell check
nnoremap <silent> <Leader>s :setl spell!<CR>

" close special windows from another window
nnoremap <silent> <Leader>q :<C-u>call <SID>close_special_windows()<CR>

function! s:close_window(winnr)
    if winbufnr(a:winnr) !=# -1
        execute a:winnr . 'wincmd w'
        execute 'wincmd c'
        return 1
    else
        return 0
    endif
endfunction

function! s:close_special_windows()
    let target_ft = [
                \ 'qf',
                \ 'help',
                \ ]
    let i = 1
    while i <= winnr('$')
        let bufnr = winbufnr(i)
        if index(target_ft, getbufvar(bufnr, '&filetype')) >= 0
            call s:close_window(i)
        endif
        let i = i + 1
    endwhile
endfunction

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

"coc.nvim
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>coc_show_documentation()<CR>

function! s:coc_show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

" sticky shift
" http://vim-jp.org/vim-users-jp/2009/08/09/Hack-54.html

function! s:sticky_func()
    let l:sticky_table = {
                \',' : '<', '.' : '>', '/' : '?',
                \'1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
                \'6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
                \';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
                \}
    let l:special_table = {
                \"\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
                \}

    let l:key = getchar()
    if nr2char(l:key) =~ '\l'
        return toupper(nr2char(l:key))
    elseif has_key(l:sticky_table, nr2char(l:key))
        return l:sticky_table[nr2char(l:key)]
    elseif has_key(l:special_table, nr2char(l:key))
        return l:special_table[nr2char(l:key)]
    else
        return ''
    endif
endfunction

cnoremap <expr> ; <SID>sticky_func()

function! s:init_sticky_shift_hook_autocmd() abort
    let s:sticky_shift_except_for_filetype = [
                \ 'c',
                \ 'cpp',
                \ 'java',
                \ 'idlang',
                \ 'javascript',
                \ 'clojure',
                \]

    if index(s:sticky_shift_except_for_filetype, &ft) < 0
        inoremap <buffer><expr> ; <SID>sticky_func()
        snoremap <buffer><expr> ; <SID>sticky_func()
    else
        inoremap <buffer> ; ;
        snoremap <buffer> ; ;
    endif
endfunction

augroup vimrc-sticky-shift
    autocmd!
    autocmd FileType * call s:init_sticky_shift_hook_autocmd()
augroup END

" QuickFix window
augroup vimrc-forQuickFix
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

" Help window
augroup vimrc-forHelpWindow
    autocmd!
    " mappings
    autocmd FileType help nnoremap <buffer> j j
    autocmd FileType help nnoremap <buffer> k k
    autocmd FileType help nnoremap <buffer> 0 0
    autocmd FileType help nnoremap <buffer> $ $
    autocmd FileType help nnoremap <buffer> gj gj
    autocmd FileType help nnoremap <buffer> gk gk
    autocmd FileType help nnoremap <buffer> g0 g0
    autocmd FileType help nnoremap <buffer> g$ g$
    autocmd FileType help nnoremap <buffer><silent>q :<C-u>q<CR>
    " autoclose
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'help' | q | endif
augroup END

augroup vimrc-filetype-force-tex
    autocmd!
    autocmd FileType latex,plaintex setlocal filetype=tex
augroup END

set laststatus=2
set showtabline=2

augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if match(a:dir, '\(scp://\|http://\|https://\)') == -1
            if !isdirectory(a:dir) && (a:force ||
                        \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
                call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
            endif
        endif
    endfunction
augroup END

augroup vimrc-session-vim-auto-load
    autocmd!
    autocmd VimEnter * nested call <SID>load_session_vim(expand('<afile>:p:h'))
augroup END

function! s:load_session_vim(loc)
    let files = findfile('Session.vim', escape(a:loc, ' ') . ';', -1)
    if !argc()
        for i in reverse(filter(files, 'filereadable(v:val)'))
            if input(printf('Session.vim exists in "%s". Load it? [y/N]', i)) =~? '^y\%[es]$'
                source `=i`
            endif
        endfor
    endif
endfunction

augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call <SID>vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction
