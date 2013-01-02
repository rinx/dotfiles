"Plugin settings


"Project.vim用設定
nmap <silent> <Leader>p <Plug>ToggleProject
autocmd BufAdd .vimprojects silent! %foldopen!
if getcwd() != $HOME
	if filereadable(getcwd(). '/.vimprojects')
		nmap <silent> <Leader>P :Project .vimprojects<CR>
	else
		nmap <silent> <Leader>P :Project<CR>
	endif
endif


"neocomplcacheの設定
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
"補完メニュー色変更
highlight Pmenu ctermbg=6
highlight PmenuSel ctermbg=2
highlight PmenuSbar ctermbg=5


"Unite.vim用キーマッピング
"バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>


"skk.vim用設定
let skk_jisyo = "~/.skk-jisyo"
let skk_large_jisyo = "/usr/share/skk/SKK-JISYO.L"
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
let skk_imdisable_state = 1


"Align.vim用設定
let g:Align_xstrlen = 3
let g:DrChipTopLvlMenu = ''


