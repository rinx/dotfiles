if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

"github repositories
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'honza/vim-snippets'

NeoBundle 'tyru/skk.vim'
"NeoBundle 'tyru/eskk.vim'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'vim-scripts/eregex.vim'

NeoBundle 'tmhedberg/matchit'

NeoBundleLazy 'eagletmt/ghcmod-vim',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'ujihisa/neco-ghc',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'dag/vim2hs',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'pbrisbin/html-template-syntax',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'moznion/hateblo.vim',{
            \ 'autoload' : {
            \   'commands' : [
            \     "HatebloCreate",
            \     "HatebloCreateDraft",
            \     "HatebloList",
            \     "HatebloUpdate",
            \     "HatebloDelete"
            \   ]
            \ }
            \}

"vim-scripts repositories
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'

