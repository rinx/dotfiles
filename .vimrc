"============================================
"               ________________________
"     .--.     /                        \
"    |o_o |   |  @gh_rinx's .vimrc      |
"    |:_/ |   /_________________________/
"   //   \ \    
"  (|     | ) 
" /'|_   _/'\ http://github.com/rinx/
" \___)=(___/ http://twitter.com/gh_rinx
"============================================

"encoding
if filereadable(expand('~/.dotfiles/vim.d/encoding.vim'))
    source ~/.dotfiles/vim.d/encoding.vim
endif

"functions
if filereadable(expand('~/.dotfiles/vim.d/functions.vim'))
    source ~/.dotfiles/vim.d/functions.vim
endif

"neobundle.vim
if filereadable(expand('~/.dotfiles/vim.d/neobundle-settings.vim'))
    source ~/.dotfiles/vim.d/neobundle-settings.vim
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

" Statusline
if filereadable(expand('~/.dotfiles/vim.d/statusline.vim'))
    source ~/.dotfiles/vim.d/statusline.vim
endif

"plugin
if filereadable(expand('~/.dotfiles/vim.d/plugin_settings.vim'))
    source ~/.dotfiles/vim.d/plugin_settings.vim
endif

"load settings for each location
augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction
