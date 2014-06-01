"( っ'ヮ'c) < loading vimrc...

"The beginning of initialization
if filereadable(expand('~/.dotfiles/vim.d/init_begin.vim'))
    source ~/.dotfiles/vim.d/init_begin.vim
endif

"Loading plugins
if filereadable(expand('~/.dotfiles/vim.d/load_plugins.vim'))
    source ~/.dotfiles/vim.d/load_plugins.vim
endif

"Basic
if filereadable(expand('~/.dotfiles/vim.d/basic.vim'))
    source ~/.dotfiles/vim.d/basic.vim
endif

"Color
if filereadable(expand('~/.dotfiles/vim.d/color.vim'))
    source ~/.dotfiles/vim.d/color.vim
endif

"Key mapping
if filereadable(expand('~/.dotfiles/vim.d/map.vim'))
    source ~/.dotfiles/vim.d/map.vim
endif

"Filetype
if filereadable(expand('~/.dotfiles/vim.d/filetype.vim'))
    source ~/.dotfiles/vim.d/filetype.vim
endif

"Statusline
if filereadable(expand('~/.dotfiles/vim.d/statusline.vim'))
    source ~/.dotfiles/vim.d/statusline.vim
endif

"The end of initialization
if filereadable(expand('~/.dotfiles/vim.d/init_end.vim'))
    source ~/.dotfiles/vim.d/init_end.vim
endif

