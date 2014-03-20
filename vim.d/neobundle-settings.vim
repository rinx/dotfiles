if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"github repositories
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimshell'

NeoBundleLazy 'Shougo/unite.vim', {
            \ 'autoload' : {
            \   'commands' : [
            \     'Unite',
            \     'UniteWithBufferDir',
            \     'UniteWithCurrentDir'
            \   ]
            \ }
            \}
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'thinca/vim-unite-history'

NeoBundle 'honza/vim-snippets'

NeoBundle 'itchyny/lightline.vim'

NeoBundle 'tyru/skk.vim'
"NeoBundle 'tyru/eskk.vim'
NeoBundle 'thinca/vim-quickrun'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'vim-scripts/eregex.vim'

NeoBundle 'tmhedberg/matchit'

NeoBundleLazy 'eagletmt/ghcmod-vim',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'ujihisa/neco-ghc',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'dag/vim2hs',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}
NeoBundleLazy 'pbrisbin/html-template-syntax',{
            \ 'autoload' : {
            \   'filetypes' : ['haskell']
            \ }
            \}

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'moznion/hateblo.vim',{
            \ 'autoload' : {
            \   'commands' : [
            \     "HatebloCreate",
            \     "HatebloCreateDraft",
            \     "HatebloList",
            \     "HatebloUpdate",
            \     "HatebloDelete"
            \   ]
            \ }
            \}

NeoBundle 'osyo-manga/vim-over'

NeoBundleLazy 'tyru/capture.vim',{
            \ 'autoload' : {
            \   'commands' : [
            \     "Capture"
            \   ]
            \ }
            \}

"textobj
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'mattn/vim-textobj-url'
NeoBundle 'osyo-manga/vim-textobj-multiblock'
NeoBundle 'osyo-manga/vim-textobj-multitextobj'

"vim-scripts repositories
NeoBundle 'surround.vim'
NeoBundle 'repeat.vim'


"Plugin settings

if s:meet_neocomplete_requirements()
    "neocomplete
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#auto_completion_start_length = 1
    let g:neocomplete#enable_smart_case = 1
    
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
else
    "neocomplcache
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_auto_completion_start_length = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
endif

"Enable omni function
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

 " For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


"Unite.vim
nnoremap [unite] <Nop>
nmap ,u [unite]
"buffer
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"tab
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
"file
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]fr :<C-u>Unite file_rec<CR>
"register
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"recently files
nnoremap <silent> [unite]m :<C-u>Unite file_mru:short<CR>
nnoremap <silent> [unite]ml :<C-u>Unite file_mru:long<CR>
"history
nnoremap <silent> [unite]hy :<C-u>Unite history/yank<CR>
"thinca/vim-unite-history
nnoremap <silent> [unite]hc :<C-u>Unite history/command<CR>
nnoremap <silent> [unite]hs :<C-u>Unite history/search<CR>


"skk.vim
let skk_jisyo = "~/.skk-jisyo"

if OSTYPE == "Darwin\n"
    let skk_large_jisyo = "/Library/Dictionaries/SKK/SKK-JISYO.LL"
elseif OSTYPE == "Linux\n"
    let skk_large_jisyo = "/usr/share/skk/SKK-JISYO.LL"
endif

let skk_auto_save_jisyo = 1
let skk_keep_state = 1
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1
let skk_marker_white = ">"
let skk_marker_black = ">>"
let skk_use_color_cursor = 1
let skk_cursor_hira_color = "#ff0000"
let skk_cursor_kata_color = "#00ff00"
let skk_cursor_zenei_color = "#ffcc00"
let skk_cursor_ascii_color = "#ffffff"
let skk_cursor_addrev_color = "#0000ff"
let skk_sticky_key = ";"
let skk_imdisable_state = 1
let skk_ascii_mode_string =  "aA"
let skk_hira_mode_string  =  "あ"
let skk_kata_mode_string  =  "ア"
let skk_zenei_mode_string =  "Ａ"
let skk_abbrev_mdoe_string = "aあ"

""eskk.vim
"let g:eskk#dictionary = "~/.skk-jisyo"
"let g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.LL"
"let g:eskk#show_annotation = 1

"syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp,*.hs,*.rb,*.py call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction


"textobj
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
vmap ab <Plug>(textobj-multiblock-a)
vmap ib <Plug>(textobj-multiblock-i)

let g:textobj_multitextobj_textobjects_i = [
    \   "\<Plug>(textobj-url-i)",
    \   "\<Plug>(textobj-multiblock-i)",
    \   "\<Plug>(textobj-function-i)",
    \   "\<Plug>(textobj-entire-i)",
\]
let g:textobj_multitextobj_textobjects_a = [
    \   "\<Plug>(textobj-url-a)",
    \   "\<Plug>(textobj-multiblock-a)",
    \   "\<Plug>(textobj-function-a)",
    \   "\<Plug>(textobj-entire-a)",
\]
omap amt <Plug>(textobj-multitextobj-a)
omap imt <Plug>(textobj-multitextobj-i)
vmap amt <Plug>(textobj-multitextobj-a)
vmap imt <Plug>(textobj-multitextobj-i)
