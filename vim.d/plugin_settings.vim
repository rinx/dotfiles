"Plugin settings

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1

"Enable omni function
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

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
let skk_large_jisyo = "/usr/share/skk/SKK-JISYO.LL"
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


