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

Plug 'romgrk/doom-one.vim'

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

syntax on
filetype off
filetype plugin indent on

set hlsearch

set termguicolors

silent! colorscheme doom-one
set background=dark

set sessionoptions+=tabpages
set sessionoptions-=options

syntax enable

" coc.nvim
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <silent><expr> <CR>
            \ pumvisible() ? coc#_select_confirm() :
            \ "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

"fzf.vim
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

highlight Normal ctermbg=none guibg=none

lua require('aniseed.env').init()
