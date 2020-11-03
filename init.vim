set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,sjis

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

Plug 'junegunn/seoul256.vim'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'itchyny/lightline.vim'
Plug 'romgrk/barbar.nvim'

Plug 'tyru/eskk.vim'

Plug 'dense-analysis/ale'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'honza/vim-snippets'

Plug 'junegunn/fzf', { 'dir': '~/.zplug/repos/junegunn/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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

Plug 'mileszs/ack.vim'
Plug 'thinca/vim-qfreplace'

Plug 'liquidz/vim-iced', { 'for': ['clojure'] }
Plug 'liquidz/vim-iced-coc-source', { 'for': ['clojure'] }

Plug 'hylang/vim-hy', { 'for': ['hy'] }
Plug 'udalov/kotlin-vim', { 'for': ['kotlin'] }

Plug 'Olical/aniseed'
Plug 'Olical/conjure', { 'for': ['fennel'] }
Plug 'bakpakin/fennel.vim', { 'for': ['fennel'] }

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/nvim-treesitter-context'

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

syntax on
filetype off
filetype plugin indent on

set hlsearch

set termguicolors

silent! colorscheme seoul256
set background=dark

if exists('&pumblend')
    set pumblend=30
endif
if exists('&winblend')
    set winblend=30
endif

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

set backupdir=~/.config/nvim/tmp/backup
set undodir=~/.config/nvim/tmp/undo
set directory=~/.config/nvim/tmp/swap

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

"coc.nvim
let g:coc_global_extensions = [
            \ 'coc-dictionary',
            \ 'coc-docker',
            \ 'coc-emoji',
            \ 'coc-git',
            \ 'coc-go',
            \ 'coc-highlight',
            \ 'coc-java',
            \ 'coc-json',
            \ 'coc-lists',
            \ 'coc-lua',
            \ 'coc-omni',
            \ 'coc-rls',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-spell-checker',
            \ 'coc-syntax',
            \ 'coc-tsserver',
            \ 'coc-word',
            \ 'coc-xml',
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

inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

nnoremap [coc-list] <Nop>
nmap ,c [coc-list]

nnoremap <silent> [coc-list]b  :<C-u>CocList buffers<CR>
nnoremap <silent> [coc-list]c  :<C-u>CocList commands<CR>
nnoremap <silent> [coc-list]d  :<C-u>CocList diagnostics<CR>
nnoremap <silent> [coc-list]f  :<C-u>CocList files<CR>
nnoremap <silent> [coc-list]gf :<C-u>CocList gfiles<CR>
nnoremap <silent> [coc-list]gs :<C-u>CocList gstatus<CR>
nnoremap <silent> [coc-list]gb :<C-u>CocList branches<CR>
nnoremap <silent> [coc-list]g  :<C-u>CocList --interactive grep<CR>
nnoremap <silent> [coc-list]h  :<C-u>CocList helptags<CR>
nnoremap <silent> [coc-list]q  :<C-u>CocList quickfix<CR>
nnoremap <silent> [coc-list]r  :<C-u>CocListResume<CR>
nnoremap <silent> [coc-list]s  :<C-u>CocList symbols<CR>
nnoremap <silent> [coc-list]t  :<C-u>CocList filetypes<CR>
nnoremap <silent> [coc-list]w  :<C-u>CocList --interactive words<CR>
nnoremap <silent> [coc-list]/  :<C-u>CocList --interactive words<CR>
nnoremap <silent> [coc-list]y  :<C-u>CocList -A yank<CR>

"fzf.vim
nnoremap [fzf] <Nop>
nmap ,u [fzf]

nnoremap <silent> [fzf]b  :<C-u>Buffers<CR>
nnoremap <silent> [fzf]f  :<C-u>Files<CR>
nnoremap <silent> [fzf]gf :<C-u>GFiles<CR>
nnoremap <silent> [fzf]/  :<C-u>BLines<CR>
nnoremap <silent> [fzf]c  :<C-u>History:<CR>
nnoremap <silent> [fzf]h  :<C-u>Helptags<CR>
nnoremap <silent> [fzf]t  :<C-u>Filetypes<CR>
nnoremap <silent> [fzf]g  :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(input('Query: ')), 1, 0)<CR>

augroup vimrc-fzf
    autocmd!
    autocmd FileType fzf nnoremap <buffer><silent>q :<C-u>q<CR>
augroup END

if exists('*nvim_open_win')
    hi NormalFloat ctermbg=237 ctermfg=252

    let g:fzf_layout = { 'window': 'call FloatingFZF()' }

    function! FloatingFZF()
      let buf = nvim_create_buf(v:false, v:true)

      let height = 20
      let width = float2nr(&columns - (&columns * 2 / 10))
      let row = float2nr((&lines - height) / 2)
      let col = float2nr((&columns - width) / 2)

      let opts = {
            \ 'relative': 'editor',
            \ 'row': row,
            \ 'col': col,
            \ 'width': width,
            \ 'height': height
            \ }

      call nvim_open_win(buf, v:true, opts)
    endfunction
endif

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
silent! call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
silent! call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
silent! call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
silent! call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
silent! call submode#map('bufmove', 'n', '', '>', '<C-w>>')
silent! call submode#map('bufmove', 'n', '', '<', '<C-w><')
silent! call submode#map('bufmove', 'n', '', '+', '<C-w>+')
silent! call submode#map('bufmove', 'n', '', '-', '<C-w>-')

"arpeggio
silent! call arpeggio#load()

"operator
let g:caw_no_default_keymappings = 1
silent! Arpeggio map or <Plug>(operator-replace)
silent! Arpeggio map oc <Plug>(caw:hatpos:toggle:operator)
silent! Arpeggio map od <Plug>(caw:hatpos:uncomment:operator)
silent! Arpeggio map oe <Plug>(caw:zeropos:toggle:operator)
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
let g:sexp_filetypes = 'clojure,scheme,lisp,fennel'
nmap <buffer> >( <Plug>(sexp_emit_head_element)
nmap <buffer> <) <Plug>(sexp_emit_tail_element)
nmap <buffer> <( <Plug>(sexp_capture_prev_element)
nmap <buffer> >) <Plug>(sexp_capture_next_element)

"iced
let g:iced_enable_default_key_mappings = v:true

"hy
let g:hy_enable_conceal = 0
let g:hy_conceal_fancy = 0

"go
augroup vimrc-golang
    autocmd!
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go setlocal shiftwidth=8
    autocmd FileType go setlocal tabstop=8
    autocmd FileType go compiler go
    autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
    let g:ale_go_golangci_lint_options = '--enable-all --disable=gochecknoglobals --disable=gochecknoinits --disable=typecheck --disable=lll --enable=gosec --enable=prealloc'
augroup END

"markdown
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = '0.0.0.0'
let g:mkdp_port = '8000'
function! g:Mkdp_echo_url(url)
    :echo a:url
endfunction
let g:mkdp_browserfunc = 'g:Mkdp_echo_url'

"json
augroup vimrc-json
    autocmd!
    autocmd FileType json setlocal shiftwidth=2
augroup END

"yaml
augroup vimrc-yaml
    autocmd!
    autocmd FileType yaml setlocal shiftwidth=2
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

highlight Normal ctermbg=none guibg=none

lua require('aniseed.env').init()
