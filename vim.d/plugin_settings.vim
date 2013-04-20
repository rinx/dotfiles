"Plugin settings

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)


"Unite.vim
"buffer
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"file
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"register
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"recently files
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>


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

""eskk.vim
"let g:eskk#dictionary = "~/.skk-jisyo"
"let g:eskk#large_dictionary = "/usr/share/skk/SKK-JISYO.LL"
"let g:eskk#show_annotation = 1


