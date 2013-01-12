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

NeoBundle 'vim-scripts/Smooth-Scroll'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/eregex.vim'

NeoBundle 'tmhedberg/matchit'
NeoBundle 'tpope/vim-rails'

"vim-scripts repositories
NeoBundle 'project.tar.gz'
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'

