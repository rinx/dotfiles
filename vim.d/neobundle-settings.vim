if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

"github repositories
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'

NeoBundle 'tyru/skk.vim'
"NeoBundle 'tyru/eskk.vim'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'vim-scripts/eregex.vim'

NeoBundle 'tmhedberg/matchit'

NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'ujihisa/neco-ghc'

"vim-scripts repositories
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'

