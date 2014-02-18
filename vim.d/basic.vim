"Basic Settings

"not vi compatible
set nocompatible	

"history
set viminfo='1000,<100,f1,h,s100
set history=300

set bs=indent,eol,start

set ruler
set number
set cursorline
set cmdheight=2
set wildmenu

set imdisable

"search
set incsearch
set ignorecase
set smartcase

"indent
filetype plugin indent on
set autoindent
set smartindent

"unsaved buffer warning
set confirm

"clipboard
set clipboard+=unnamed,autoselect

"mouse
set mouse=a
set ttymouse=xterm2

"fold
set foldmethod=marker

"visual select
set virtualedit=block

"tab
set expandtab
"set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4

"for multibyte
set ambiwidth=double

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

"backup file
set nobackup

set conceallevel=0
set visualbell

"for session
set sessionoptions+=tabpages

"showmatch
set showmatch
set matchtime=3
