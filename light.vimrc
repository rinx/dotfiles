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

let s:plug_dir = '~/.config/lightvim/plugged'

let s:plug_repo_dir = s:plug_dir . '/vim-plug'

if !isdirectory(expand(s:plug_repo_dir))
    call mkdir(expand(s:plug_repo_dir), "p")
    call system('git clone https://github.com/junegunn/vim-plug.git ' . expand(s:plug_repo_dir) . '/autoload')
endif

if has('vim_starting')
    execute 'set runtimepath+=' . s:plug_repo_dir
endif

call plug#begin(expand(s:plug_dir))

Plug 'junegunn/vim-plug', {'dir': '~/.config/lightvim/plugged/vim-plug/autoload'}

Plug 'itchyny/lightline.vim'
Plug 'junegunn/seoul256.vim'

Plug 'w0rp/ale'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install() }}

Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-gitgutter'

Plug 'cohama/lexima.vim'

Plug 'haya14busa/vim-asterisk'

Plug 'haya14busa/incsearch.vim'

Plug 'rhysd/clever-f.vim'

Plug 't9md/vim-quickhl'

Plug 'kana/vim-submode'
Plug 'kana/vim-arpeggio'

Plug 'tyru/caw.vim'

Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'rhysd/vim-operator-surround'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'thinca/vim-textobj-between'
Plug 'mattn/vim-textobj-url'
Plug 'osyo-manga/vim-textobj-multiblock'

Plug 'tpope/vim-repeat'
Plug 'guns/vim-sexp'

Plug 'fatih/vim-go', { 'for': ['go'] }

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
filetype plugin indent on

set hlsearch

if empty($TMUX) && empty($STY)
  " See https://gist.github.com/XVilka/8346728.
  if $COLORTERM =~# 'truecolor' || $COLORTERM =~# '24bit'
    if has('termguicolors')
      " See :help xterm-true-color
      if $TERM =~# '^screen'
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      endif
      set termguicolors
    endif
  endif
endif

colorscheme seoul256
set background=dark

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

"ale.vim
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_set_quickfix = 1
let g:ale_set_loclist = 0
let g:ale_open_list = 1

let g:ale_sign_column_always = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1


"coc.nvim
let g:coc_global_extensions = [
            \ 'coc-dictionary',
            \ 'coc-emoji',
            \ 'coc-gocode',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-omni',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-tsserver',
            \ 'coc-word',
            \ 'coc-yaml',
            \ 'coc-yank'
            \]
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

nnoremap [coc-list] <Nop>
nmap ,c [coc-list]

nnoremap <silent> [coc-list]b :<C-u>CocList buffers<CR>
nnoremap <silent> [coc-list]c :<C-u>CocList commands<CR>
nnoremap <silent> [coc-list]d :<C-u>CocList diagnostics<CR>
nnoremap <silent> [coc-list]f :<C-u>CocList files<CR>
nnoremap <silent> [coc-list]g :<C-u>CocList --interactive grep<CR>
nnoremap <silent> [coc-list]q :<C-u>CocList quickfix<CR>
nnoremap <silent> [coc-list]r :<C-u>CocListResume<CR>
nnoremap <silent> [coc-list]s :<C-u>CocList symbols<CR>
nnoremap <silent> [coc-list]w :<C-u>CocList words<CR>
nnoremap <silent> [coc-list]y :<C-u>CocList -A yank<CR>

"fzf.vim
nnoremap [fzf] <Nop>
nmap ,u [fzf]

nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]gf :<C-u>GFiles<CR>
nnoremap <silent> [fzf]/ :<C-u>BLines<CR>
nnoremap <silent> [fzf]c :<C-u>History:<CR>
nnoremap <silent> [fzf]h :<C-u>Helptags<CR>
nnoremap <silent> [fzf]t :<C-u>Filetypes<CR>
nnoremap <silent> [fzf]g :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(input('Query: ')), 1, 0)<CR>

"gitgutter
let g:gitgutter_highlight_lines = 1
let g:gitgutter_max_signs = 10000
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '*'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '~'

"lexima
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
let g:lexima_map_escape = '<Esc>'

let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_space_rules = 1
let g:lexima_enable_endwise_rules = 1

"asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

"incsearch
map <buffer>/  <Plug>(incsearch-forward)
map <buffer>?  <Plug>(incsearch-backward)
map <buffer>g/ <plug>(incsearch-stay)

"clever-f
let g:clever_f_not_overwrites_standard_mappings = 1
let g:clever_f_across_no_line = 0
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_use_migemo = 0
let g:clever_f_fix_key_direction = 0
let g:clever_f_show_prompt = 0
let g:clever_f_chars_match_any_signs = ''
let g:clever_f_mark_cursor = 1
let g:clever_f_mark_cursor_color = 'Cursor'
let g:clever_f_hide_cursor_on_cmdline = 1
let g:clever_f_timeout_ms = 0
let g:clever_f_mark_char = 1
let g:clever_f_mark_char_color = 'CleverFDefaultLabel'
let g:clever_f_repeat_last_char_inputs = ["\<CR>"]
nmap f <Plug>(clever-f-f)
nmap F <Plug>(clever-f-F)
nmap t <Plug>(clever-f-t)
nmap T <Plug>(clever-f-T)
nmap <Space> <Plug>(clever-f-reset)

"quickhl
nmap <Space>m <Plug>(quickhl-manual-this)
xmap <Space>m <Plug>(quickhl-manual-this)
nmap <Space>M <Plug>(quickhl-manual-reset)
xmap <Space>M <Plug>(quickhl-manual-reset)

"submode
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"arpeggio
call arpeggio#load()

"operator
let g:caw_no_default_keymappings = 1
Arpeggio map or <Plug>(operator-replace)
Arpeggio map oc <Plug>(caw:hatpos:toggle:operator)
Arpeggio map od <Plug>(caw:hatpos:uncomment:operator)
Arpeggio map oe <Plug>(caw:zeropos:toggle:operator)
map Sa <Plug>(operator-surround-append)
map Sd <Plug>(operator-surround-delete)
map Sr <Plug>(operator-surround-replace)

"textobj
let g:textobj_between_no_default_key_mappings = 1
omap ac <Plug>(textobj-between-a)
omap ic <Plug>(textobj-between-i)
vmap ac <Plug>(textobj-between-a)
vmap ic <Plug>(textobj-between-i)
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)

"sexp
let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_insert_after_wrap = 0
nmap <silent><buffer> >( <Plug>(sexp_emit_head_element)
nmap <silent><buffer> <) <Plug>(sexp_emit_tail_element)
nmap <silent><buffer> <( <Plug>(sexp_capture_prev_element)
nmap <silent><buffer> >) <Plug>(sexp_capture_next_element)

"vim-go
let g:go_fmt_command = 'goimports'
augroup vimrc-golang
    autocmd!
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal sw=8
    autocmd FileType go setlocal ts=8
    autocmd FileType go compiler go
augroup END

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

let g:lightline = {
            \ 'active': {
            \   'left': [
            \             [ 'mode', 'paste', 'spell' ],
            \             [ 'filename', 'cocstatus' ],
            \   ],
            \   'right': [
            \             [ 'lineinfo' ],
            \             [ 'percent' ],
            \             [ 'fileformat', 'fileencoding', 'filetype' ],
            \   ],
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'mode': 'MyMode',
            \   'cocstatus': 'coc#status',
            \   'tablineabspath': 'MyAbsPath',
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
            \     [ 'tablineabspath' ],
            \   ],
            \ },
            \ 'colorscheme': 'seoul256',
            \ }

function! MyModified()
    return &ft =~ 'help\|vaffle\|undotree\|nerdtree\|qf\|quickrun' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vaffle\|undotree\|nerdtree\|qf\|quickrun' && &ro ? 'RO' : ''
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
    return &ft == 'vaffle' ? 'Vaffle' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'denite' ? 'Denite' :
                \ &ft == 'undotree' ? 'UNDOtree' :
                \ &ft == 'nerdtree' ? 'NERDtree' :
                \ &ft == 'qf' ? 'QuickFix' :
                \ &ft == 'quickrun' ? '' :
                \ winwidth('.') > 60 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'qf' ? len(getqflist()) . ' fixes' :
                \  &ft == 'quickrun' ? 'QuickRun' :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MySkkgetmode()
    if s:enable_eskk
        let _ = eskk#get_mode()
    else
        let _ = SkkGetModeStr()
    endif
    return winwidth('.') > 70 ? strlen(_) ? substitute(_, '\[\|\]', '', 'g') : '' : ''
endfunction

function! MyAbsPath()
    let _ = expand('%:p:h')
    return &ft == 'vaffle' ? '' :
                \ &ft == 'unite' ? '' :
                \ &ft == 'denite' ? '' :
                \ &ft == 'qf' ? '' :
                \ &ft == 'quickrun' ? '' :
                \ tabpagenr('$') > 3 ? '' :
                \ strlen(_) < winwidth('.') / 2 ? _ : ''
endfunction

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

highlight Normal ctermbg=none
