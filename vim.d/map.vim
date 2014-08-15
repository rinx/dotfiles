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

inoremap <Left> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>

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

"Access to system clipboard
nnoremap ,p "+p
nnoremap ,P "+P
nnoremap ,y "+y
nnoremap ,d "+d

vnoremap ,y "+y
vnoremap ,d "+d

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
nnoremap [Tab] <Nop>
nmap ,t [Tab]

for n in range(1, 9)
    execute 'nnoremap <silent> [Tab]'.n ':<C-u>tabnext'.n.'<CR>'
endfor

nnoremap <silent> [Tab]c :<C-u>tablast <bar> tabnew<CR>
nnoremap <silent> [Tab]x :<C-u>tabclose<CR>
nnoremap <silent> [Tab]n :<C-u>tabnext<CR>
nnoremap <silent> [Tab]p :<C-u>tabprevious<CR>

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
nnoremap <silent> <Leader>p :setl paste!<CR>

"toggle relativenumber
nnoremap <silent> <Leader>r :setl relativenumber!<CR>

"close special windows from another window
nnoremap <silent> <Leader>q :<C-u>call <SID>close_special_windows()<CR>

function! s:close_window(winnr)
    if winbufnr(a:winnr) !=# -1
        execute a:winnr . 'wincmd w'
        execute 'wincmd c'
        return 1
    else
        return 0
    endif
endfunction

function! s:close_special_windows()
    let target_ft = [
                \ 'ref',
                \ 'unite',
                \ 'vimfiler',
                \ 'vimshell',
                \ 'qf',
                \ 'quickrun',
                \ 'gundo',
                \ 'nerdtree',
                \ 'help',
                \ ]
    let i = 1
    while i <= winnr('$')
        let bufnr = winbufnr(i)
        if index(target_ft, getbufvar(bufnr, '&filetype')) >= 0
            call s:close_window(i)
        endif
        let i = i + 1
    endwhile
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
    Arpeggio nmap msu [unite]msu
    call neobundle#untap()
endif


