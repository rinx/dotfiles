"Control settings

"reload .vimrc
nnoremap <C-r><C-f> :source ~/.vimrc<CR>

"Use cursor-key to switch between window
nnoremap <Left> <C-w>h
nnoremap <Down> <C-w>j
nnoremap <Up> <C-w>k
nnoremap <Right> <C-w>l

"Use Emacs-like keybinds on insert-mode
inoremap <C-b> <Left>
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>
inoremap <C-f> <Right>

"Use Emacs-like keybinds on command-mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

