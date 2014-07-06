" --- Mappings ---

let mapleader = '\'

"reload .vimrc
nnoremap <C-r><C-f> :source ~/.vimrc<CR>

"For US-keyboard
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

"Disable cursor keys
nnoremap <Left> <Nop>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <Right> <Nop>

"Remap to act as expected
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

"Reverse of above
nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g$ $

"Use Y as y$
nnoremap Y y$

"Use Emacs-like keybinds on insert-mode
inoremap <C-b> <Left>
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>
inoremap <C-f> <Right>

"Use Emacs-like keybinds on command-mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

"Use completion with C-p or C-n on command-mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

"for tabline
nnoremap [Tag] <Nop>
nmap t [Tag]

for n in range(1, 9)
    execute 'nnoremap <silent> [Tag]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

nnoremap <silent> [Tag]c :<C-u>tablast <bar> tabnew<CR>
nnoremap <silent> [Tag]x :<C-u>tabclose<CR>
nnoremap <silent> [Tag]n :<C-u>tabnext<CR>
nnoremap <silent> [Tag]p :<C-u>tabprevious<CR>

"for window
nnoremap s <Nop>
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l
nnoremap <silent> sh <C-w>h
nnoremap <silent> sJ <C-w>J
nnoremap <silent> sK <C-w>K
nnoremap <silent> sL <C-w>L
nnoremap <silent> sH <C-w>H
nnoremap <silent> sr <C-w>r
nnoremap <silent> sw <C-w>w
nnoremap <silent> s_ <C-w>_
nnoremap <silent> s| <C-w>|
nnoremap <silent> so <C-w>_<C-w>|
nnoremap <silent> sO <C-w>=
nnoremap <silent> s= <C-w>=
nnoremap <silent> ss :<C-u>sp<CR>
nnoremap <silent> sv :<C-u>vs<CR>

if neobundle#tap('vim-submode')
    call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
    call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
    call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
    call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
    call submode#map('bufmove', 'n', '', '>', '<C-w>>')
    call submode#map('bufmove', 'n', '', '<', '<C-w><')
    call submode#map('bufmove', 'n', '', '+', '<C-w>+')
    call submode#map('bufmove', 'n', '', '-', '<C-w>-')

    call neobundle#untap()
endif

"nohilight by pressing Esc twice
nnoremap <Esc><Esc> :nohlsearch<CR>

"toggle paste mode
nnoremap <Leader>p :setl paste!<CR>

"toggle relative or absolute number
nnoremap <Leader>r :<C-u>call <SID>rel_ab_number()<CR>
function! s:rel_ab_number()
    if &relativenumber
        setl norelativenumber
    else
        setl relativenumber
    endif
endfunction

"disable some default mappings
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

if neobundle#tap('unite.vim')
    " for Unite-menu:shortcut
    Arpeggio nmap msa [unite]ms
    Arpeggio nmap msc [unite]msc
    Arpeggio nmap msd [unite]msd
    Arpeggio nmap msf [unite]msf
    call neobundle#untap()
endif


