if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"github repositories
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell'

NeoBundleLazy 'Shougo/unite.vim', {
            \ 'autoload' : {
            \   'commands' : [
            \     'Unite',
            \     'UniteWithBufferDir',
            \     'UniteWithCurrentDir'
            \   ]
            \ }
            \}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-unite-history'

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

NeoBundle 'osyo-manga/vim-over'

"vim-scripts repositories
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'

