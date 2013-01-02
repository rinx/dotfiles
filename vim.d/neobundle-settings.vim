if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle/'))
endif

"github repositories
"NeoBundle 'Shougo/neobundle.vim/'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tyru/skk.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'vim-scripts/Smooth-Scroll'

"vim-scripts repositories
NeoBundle 'project.tar.gz'
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'

