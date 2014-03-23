NeoBundle 'tomasr/molokai'

syntax enable
if !exists('g:colors_name')
    set background=dark
    colorscheme molokai 
endif

hi Normal ctermbg=none
