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

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'nvim-lua/diagnostic-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'

Plug 'honza/vim-snippets'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'junegunn/fzf', { 'dir': '~/.zinit/plugins/junegunn---fzf', 'do': './install --bin' }
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

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'romgrk/nvim-treesitter-context'

call plug#end()

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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

lua require('aniseed.env').init()
