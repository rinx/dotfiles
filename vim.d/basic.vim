"Basic Settings

set nocompatible	
set bs=indent,eol,start
set ai
set viminfo='20,\"50

set history=50
set ruler
set number
set cmdheight=2
set wildmenu

set ignorecase
set smartcase

set autoindent
set smartindent

set confirm

set mouse=a
set ttymouse=xterm2

set foldmethod=marker
set virtualedit=block

set expandtab
"set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin indent on

if &term=="xterm"
     set t_Co=256
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

set imdisable

