"( っ'ヮ'c) < loading vimrc...
" ----------------------------------------
" Author: Rintaro Okamura
" URL:    http://rinx.biz
" Source: https://github.com/rinx/dotfiles
" ----------------------------------------

" --- The beginning of initialization ---

"not vi compatible
if has('vim_starting')
    set nocompatible
endif

"encoding

set encoding=utf-8
scriptencoding utf-8

set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,sjis


"define functions

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" --- for tabline

" Set tabline.
function! s:my_tabline()
    let s = ''

    for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears

        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '

        " Use gettabvar().
        let title = fnamemodify(bufname(bufnr), ':t')

        let title = '[' . title . ']'

        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
    endfor

    let s .= '%#TabLineFill#%T%=%#TabLine#'
    return s
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

let g:vimrc_private = {}
if filereadable(expand('~/.vimrc_private'))
    execute 'source' expand('~/.vimrc_private')
endif

" -- Plugin settings
function! s:init_neocomplete_hook_source() abort
    let g:neocomplete#enable_at_startup = 1

    let g:neocomplete#min_keyword_length = 3
    let g:neocomplete#sources#syntax#min_keyword_length = 3

    let g:neocomplete#auto_completion_start_length = 2
    let g:neocomplete#manual_completion_start_length = 0

    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_camel_case = 1

    let g:neocomplete#enable_fuzzy_completion = 1

    let g:neocomplete#enable_auto_select = 0
    let g:neocomplete#enable_refresh_always = 0
    let g:neocomplete#enable_cursor_hold_i = 0
    let g:neocomplete#enable_auto_delimiter = 1

    let g:neocomplete#max_list = 80

    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'

    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

    if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

    if !exists('g:neocomplete#sources#dictionary#dictionaries')
      let g:neocomplete#sources#dictionary#dictionaries = {}
    endif
    let g:neocomplete#sources#dictionary#dictionaries.vimshell = expand('~/.vimshell/command-history')
    let g:neocomplete#sources#dictionary#dictionaries.tweetvim_say =  expand('~/.tweetvim/screen_name')

    let g:neocomplete#enable_auto_close_preview = 1
endfunction

function! s:init_neocomplete_hook_add() abort
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
endfunction

"Enable omni function
augroup vimrc-omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

function! s:init_neosnippet_hook_add() abort
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)

    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = [
                \ expand('~/.vim/bundle/vim-snippets/snippets'),
                \ expand('~/.vim/my-snippets'),
                \]

    let g:neosnippet#enable_snipmate_compatibility = 1

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For snippet_complete marker.
"     if has('conceal')
"         set conceallevel=2 concealcursor=i
"     endif

    augroup vimrc-neosnippet
        autocmd FileType neosnippet setlocal noexpandtab
    augroup END
endfunction

function! s:init_vimfiler_hook_add() abort
    let g:vimfiler_force_overwrite_statusline = 0
endfunction

function! s:init_vimshell_hook_add() abort
    let g:vimshell_force_overwrite_statusline = 0

    nnoremap <silent> ,v :<C-u>VimShell<CR>

    let g:vimshell_prompt_expr =
        \ 'escape(fnamemodify(getcwd(), ":~")."%", "\\[]()?! ")." "'
    let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+% '

    let g:vimshell_external_history_path = expand('~/.zsh_history')
endfunction

function! s:init_arpeggio_hook_add() abort
    call arpeggio#load()
endfunction

function! s:init_unite_hook_source() abort
    let g:unite_force_overwrite_statusline = 0
    let g:unite_enable_start_insert = 0
    let g:unite_source_history_yank_enable = 1
    let g:unite_source_history_yank_limit = 1000
    let g:unite_prompt = '❯ '

    if !exists('g:unite_source_menu_menus')
        let g:unite_source_menu_menus = {}
    endif
    let g:unite_source_menu_menus.shortcut = {
                \ 'description' : 'shortcut'
                \}
    if has('mac')
        let s:copyToClipboardCommand = 'w !pbcopy'
    elseif has('unix')
        let s:copyToClipboardCommand = 'w !xsel --clipboard --input'
    endif
    let g:unite_source_menu_menus.shortcut.candidates = [
                \ ['home', $HOME],
                \ ['dotfiles', $HOME . '/.dotfiles'],
                \ ['vimrc', $MYVIMRC],
                \ ['vimshell', 'VimShell'],
                \ ['quickrun', 'QuickRun'],
                \ ['make(quickrun)', 'QuickRun make'],
                \ ['watchdogs', 'WatchdogsRun'],
                \ ['Gundo', 'GundoToggle'],
                \ ['NERDTree', 'NERDTreeToggle'],
                \ ['map', 'Unite output:map'],
                \ ['register', 'Unite output:register'],
                \ ['reload .vimrc', 'source ~/.vimrc'],
                \ ['make Session.vim', 'mks!'],
                \ ['toggle-options', 'Unite menu:toggle'],
                \ ['unite neosnippet', 'Unite neosnippet'],
                \ ['unite gista', 'Unite gista'],
                \ ['unite codic', 'Unite codic -start-insert'],
                \ ['unite radiko', 'Unite radiko'],
                \ ['stop radiko', 'RadikoStop'],
                \ ['unite RN2-musics', 'Unite rn2musics -no-quit'],
                \ ['RN2-click-de-onair', 'http://www.radionikkei.jp/rn2/cdo/'],
                \ ['skk-kutouten-type-en', 'let g:skk_kutouten_type = "en"'],
                \ ['skk-kutouten-type-jp', 'let g:skk_kutouten_type = "jp"'],
                \ ['TweetVim home-timeline', 'TweetVimHomeTimeline'],
                \ ['TweetVim UserStream', 'TweetVimUserStream'],
                \ ['J6uil lingr-client', 'J6uil'],
                \ ['PreVim open', 'PreVimOpen'],
                \ ['hateblo list', 'HatebloList'],
                \ ['copy buffer into clipboard', s:copyToClipboardCommand],
                \ ['vim-jp', 'http://vim-jp.org/'],
                \ ['reading-vimrc', 'http://vim-jp.org/reading-vimrc/'],
                \ ['Github', 'https://github.com/'],
                \ ['Github Gist', 'https://gist.github.com/'],
                \ ['Japan Meteorological Agency(JMA)', 'http://www.jma.go.jp/'],
                \ ['stackoverflow', 'http://stackoverflow.com/'],
                \]
    function! g:unite_source_menu_menus.shortcut.map(key, value)
        let [word, value] = a:value

        if isdirectory(value)
            return {
                        \ 'word' : '[directory] '.word,
                        \ 'kind' : 'directory',
                        \ 'action__directory' : value,
                        \}
        elseif !empty(glob(value))
            return {
                        \ 'word' : '[file] '.word,
                        \ 'kind' : 'file',
                        \ 'default_action' : 'tabdrop',
                        \ 'action__path' : value,
                        \}
        elseif value =~ '^\(http\|https\|ftp\).*'
            return {
                        \ 'word' : '[url] '.word,
                        \ 'kind' : 'command',
                        \ 'action__command' : 'OpenBrowser '.value,
                        \}
        else
            return {
                        \ 'word' : '[command] '.word,
                        \ 'kind' : 'command',
                        \ 'action__command' : value,
                        \}
        endif
    endfunction

    command! -nargs=1 ToggleOption set <args>! <bar> set <args>?
    let g:unite_source_menu_menus.toggle = {
                \ 'description' : 'toggle menus',
                \}
    let g:unite_source_menu_menus.toggle.command_candidates = {
                \
                \}
    let options = "
                \ paste rule number relativenumber
                \ list
                \ hlsearch wrap spell
                \ "
    for opt in split(options)
        let g:unite_source_menu_menus.toggle.command_candidates[opt] = "ToggleOption " . opt
    endfor
    unlet options opt

    let g:unite_source_menu_menus.kaomoji = {
                \ 'description' : 'kaomoji dictionary',
                \}
    let g:unite_source_menu_menus.kaomoji.candidates= [
                \["", "( 'ω').｡oO(…)"],
                \["", "ヾ(⌒(\_•ω•)\_"],
                \["", "ヾ(⌒(ﾉ•ω•)ﾉ"],
                \["", "(っ'ヮ')っ"],
                \["", "(((っ'ヮ')っ"],
                \["kyun", "\_(⌒(\_*'ω'*)\_"],
                \["kyun", "ヾ(⌒(\_*'ω'*)\_"],
                \["kyun", "三ヾ(⌒(\_*'ω'*)\_"],
                \["kyun", "（*/ω＼*）"],
                \["kyun", "(っ´ω`c)♡"],
                \["namida", "\.˚‧º·(´ฅωฅ｀)‧º·˚."],
                \["namida", "(☍﹏⁰)"],
                \["namida", "( ˃﹏˂ഃ )"],
                \["hawawa", "｡ﾟ(ﾟ∩´﹏`∩ﾟ)ﾟ｡"],
                \["hawawa", "\:;( っ'﹏'c);:"],
                \["hawawa", "\:;( っ'ω'c);:"],
                \["hawawa", "\:;(∩´﹏`∩);:"],
                \["dame", "(乂'ω')"],
                \["hawawa", "(っ´﹏`c)"],
                \["hawawa", "(｡>﹏<｡)"],
                \["awawa", "ヾ(∂╹Δ╹)ﾉ”"],
                \["firstspring", "(╯•﹏•╰)"],
                \["fuee", "ヾ(｡>﹏<)ﾉ\""],
                \["fuee", "✧*。ヾ(｡>﹏<｡)ﾉﾞ。*✧"],
                \["ja-n", "٩( 'ω' )و"],
                \["ja-n", "٩(*'ω'*)و"],
                \["panpaka", "＼＼\\٩( 'ω' )و /／／"],
                \["crow", "( っ'ω'c)"],
                \["crow", "三( っ'ω'c)"],
                \["crow", "( っ˘ω˘c)"],
                \["wahhab", "( っ'ヮ'c)"],
                \["wahhab", "三( っ'ヮ'c)"],
                \["poyo", "(´,,•ω•,,｀)"],
                \["poyo", "(｡・﹏・｡)"],
                \["mogumogu", "(∩´〰`∩)"],
                \["mogumogu", "ŧ‹\"ŧ‹\"(๑´ㅂ`๑)ŧ‹\"ŧ‹\""],
                \["pero", "(๑´ڡ`๑)"],
                \["juru", "(๑╹﹃╹)"],
                \["makimono", "(๑╹◡╹)o[]o"],
                \["matomo", "σ(o'v'o)まとも"],
                \["pei", "(っ`ω´c)"],
                \["chu", "(っ＞ω＜c)"],
                \["chu", "°+♡:.(っ>ω<c).:♡+°"],
                \["kichigai", "└(՞ةڼ◔)」"],
                \["teokure", "ヾ(〄⌒ー⌒〄)ノ"],
                \["teokure", "ヽ('ω')ﾉ=͟͟͞͞=͟͟͞͞ヽ('ω')ﾉ"],
                \["wa-i", "ヾ(✿╹◡╹)ﾉ\""],
                \["wa-i", "ヾ(๑╹◡╹)ﾉ\""],
                \["wa-i", "ヾ(＠⌒ー⌒＠)ノ"],
                \["peta", "\_(⌒(\_-ω-)\_"],
                \["osenbe", "〄"],
                \["nyanpasu", "ฅ(๑'Δ'๑)"],
                \["mikori", "ヾ(⌒(\_๑›◡‹ )\_"],
                \["mozomozo", "(๑•﹏•)"],
                \["kirakira", "✲ﾟ｡.(✿╹◡╹)ﾉ☆.｡₀:*ﾟ✲ﾟ*:₀｡"],
                \["kyafu", "(⋈◍＞◡＜◍)。✧♡"],
                \["wafu", "ヾ(✿＞ヮ＜)ノ"],
                \["gu", "╭( ･ㅂ･)و ̑̑ ｸﾞｯ !"],
                \["yossha", "(´◔౪◔)۶ﾖｯｼｬ!"],
                \["tanoshii", "✌('ω'✌ )三✌('ω')✌三( ✌'ω')✌"],
                \["yatta", "+。:.ﾟ٩(๑＞◡＜๑)۶:.｡+ﾟ"],
                \["shobon", "(っ◞‸◟c)"],
                \["shobon", "(๑´╹‸╹`๑)"],
                \["nikkori", "( っ'◡'c)"],
                \["beer", "Ʊ\"-ʓ"],
                \["beer", "🍺"],
                \["angry", "💢"],
                \["sushi", "🍣"],
                \["yes", "🙆"],
                \["no", "🙅🏻"],
                \["heart", "❤"],
                \["camera", "📸"],
                \["fire", "🔥"],
                \["arm", "💪🏻"],
                \["stop", "✋🏻"]
                \]
    function! g:unite_source_menu_menus.kaomoji.map(key, value)
        let [word, value] = a:value
        if !empty(word)
            return {
                        \ 'word' : '[' .word .'] ' .value,
                        \ 'kind' : 'word',
                        \ 'action__text' : value,
                        \}
        else
            return {
                        \ 'word' : '[no pronounciation] ' .value,
                        \ 'kind' : 'word',
                        \ 'action__text' : value,
                        \}
        endif
    endfunction
endfunction

function! s:init_unite_hook_add() abort
    nnoremap [unite] <Nop>
    nmap ,u [unite]
    "buffer
    nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
    "commands
    nnoremap <silent> [unite]c   :<C-u>Unite command<CR>
    "tab
    nnoremap <silent> [unite]t   :<C-u>Unite tab<CR>
    "file
    nnoremap <silent> [unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]fr  :<C-u>Unite file_rec<CR>
    "resume
    nnoremap <silent> [unite]r   :<C-u>UniteResume<CR>
    "register
    nnoremap <silent> [unite]rg  :<C-u>Unite -buffer-name=register register<CR>
    "recently files
    nnoremap <silent> [unite]m   :<C-u>Unite file_mru:short<CR>
    nnoremap <silent> [unite]ml  :<C-u>Unite file_mru:long<CR>
    "menu
    nnoremap <silent> [unite]ms  :<C-u>Unite menu:shortcut<CR>
    nnoremap <silent> [unite]msd :<C-u>Unite menu:shortcut -input=[directory]\ <CR>
    nnoremap <silent> [unite]msf :<C-u>Unite menu:shortcut -input=[file]\ <CR>
    nnoremap <silent> [unite]msc :<C-u>Unite menu:shortcut -input=[command]\ <CR>
    nnoremap <silent> [unite]msu :<C-u>Unite menu:shortcut -input=[url]\ <CR>
    nnoremap <silent> [unite]mk  :<C-u>Unite menu:kaomoji -start-insert<CR>
    "source
    nnoremap <silent> [unite]s   :<C-u>Unite source<CR>
    "history
    nnoremap <silent> [unite]hy  :<C-u>Unite history/yank<CR>
    "thinca/vim-unite-history
    nnoremap <silent> [unite]hc  :<C-u>Unite history/command<CR>
    nnoremap <silent> [unite]hs  :<C-u>Unite history/search<CR>
    "Shougo/unite-outline
    nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]oq  :<C-u>Unite -no-quit -buffer-name=outline outline<CR>
    "tsukkee/unite-help
    nnoremap <silent> [unite]he  :<C-u>Unite -start-insert help<CR>
    "rinx/radiko
    nnoremap <silent> [unite]rdk :<C-u>Unite radiko -no-quit<CR>
    nnoremap <silent> [unite]rn2 :<C-u>Unite rn2musics -no-quit<CR>
endfunction

function! s:init_skk_hook_add() abort
    let g:skk_jisyo = '~/.skk-jisyo'

    if has('mac')
        let g:skk_large_jisyo = '/Library/Dictionaries/SKK/SKK-JISYO.LL'
    elseif has('unix')
        let g:skk_large_jisyo = '/usr/share/skk/SKK-JISYO.LL'
    endif

    let g:skk_auto_save_jisyo = 1
    let g:skk_manual_save_jisyo_keys = ""
    let g:skk_external_prog = ""
    let g:skk_control_j_key = "<C-j>"
    let g:skk_keep_state = 1
    let g:skk_egg_like_newline = 1
    let g:skk_show_annotation = 0
    let g:skk_use_face = 0
    let g:skk_initial_mode = "hira"
    let g:skk_marker_white = ">"
    let g:skk_marker_black = ">>"
    let g:skk_marker_okuri = "*"
    let g:skk_start_henkan_key = " "
    let g:skk_prev_cand_key = "x"
    let g:skk_purge_cand_key = "X"
    let g:skk_show_candidates_count = 3
    let g:skk_completion_key = "\<Tab>"
    let g:skk_next_comp_key = "."
    let g:skk_prev_comp_key = ","
    let g:skk_special_midasi_keys = "<>?"
    let g:skk_henkan_point_keys = "ABCDEFGHIJKMNOPRSTUVWYZ"
    let g:skk_select_cand_keys = "ASDFJKL"
    let g:skk_use_color_cursor = 0
    let g:skk_cursor_hira_color = '#ff0000'
    let g:skk_cursor_kata_color = '#00ff00'
    let g:skk_cursor_zenei_color = '#ffcc00'
    let g:skk_cursor_ascii_color = '#ffffff'
    let g:skk_cursor_addrev_color = '#0000ff'
    let g:skk_sticky_key = ';'
    let g:skk_imdisable_state = 1
    let g:skk_ascii_mode_string =  'aA'
    let g:skk_hira_mode_string  =  'あ'
    let g:skk_kata_mode_string  =  'ア'
    let g:skk_zenei_mode_string =  'Ａ'
    let g:skk_abbrev_mode_string = 'aあ'
    let g:skk_kutouten_type = "en"
    let g:skk_kutouten_jp = "。、"
    let g:skk_kutouten_en = "．，"

    "toggle skk-kutouten-type
    nnoremap <silent> <Leader>k :<C-u>call <SID>toggle_skk_kutouten_type()<CR>

    function! s:toggle_skk_kutouten_type()
        if g:skk_kutouten_type == "en"
            let g:skk_kutouten_type = "jp"
            echo "g:skk_kutouten_type has been changed as 'jp'"
        else
            let g:skk_kutouten_type = "en"
            echo "g:skk_kutouten_type has been changed as 'en'"
        endif
    endfunction
endfunction

function! s:init_eskk_hook_add() abort
    let g:eskk#dictionary = {
                \ 'path' : '~/.skk-jisyo',
                \ 'sorted' : 0,
                \ 'encoding' : 'euc_jp',
                \}
    if has('mac')
        let g:eskk#large_dictionary = {
                    \ 'path' : '/Library/Dictionaries/SKK/SKK-JISYO.LL',
                    \ 'sorted' : 0,
                    \ 'encoding' : 'euc_jp',
                    \}
    elseif has('unix')
        let g:eskk#large_dictionary = {
                    \ 'path' : '/usr/share/skk/SKK-JISYO.LL',
                    \ 'sorted' : 0,
                    \ 'encoding' : 'euc_jp',
                    \}
    endif
    let g:eskk#auto_save_dictionary_at_exit = 1
    let g:eskk#dictionary_save_count = 10
    let g:eskk#select_cand_keys = "asdfjkl"
    let g:eskk#show_candidates_count = 3
    let g:eskk#kata_convert_to_hira_at_henkan = 1
    let g:eskk#kata_convert_to_hira_at_completion = 1
    let g:eskk#show_annotation = 1
    let g:eskk#kakutei_when_unique_candidate = 1
    let g:eskk#no_default_mappings = 0
    let g:eskk#dont_map_default_if_already_mapped = 0
    let g:eskk#statusline_mode_strings = {
                \ 'hira' : 'あ',
                \ 'kata' : 'ア',
                \ 'ascii' : 'aA',
                \ 'zenei' : 'ａ',
                \ 'hankata' : 'ｧｱ',
                \ 'abbrev' : 'aあ',
                \}
    let g:eskk#marker_henkan = ">"
    let g:eskk#marker_okuri = "*"
    let g:eskk#marker_henkan_select =">>"
    let g:eskk#marker_jisyo_touroku = "?"
    let g:eskk#enable_completion = 1
    let g:eskk#max_candidates = 15
    let g:eskk#start_completion_length = 2
    let g:eskk#register_completed_word = 1
    let g:eskk#use_color_cursor = 0
    "Maybe conflict with arpeggio.vim
    "let g:eskk#keep_state = 1
endfunction

function! s:init_quickrun_hook_add() abort
    Arpeggio nmap qr <Plug>(quickrun)
    let g:quickrun_config = {
                \ '_' : {
                \   'outputter' : 'error',
                \   'outputter/error/success' : 'buffer',
                \   'outputter/error/error' : 'quickfix',
                \   'outputter/buffer/close_on_empty' : 1,
                \   'outputter/buffer/split' : ':botright 8sp',
                \   'outputter/buffer/running_mark' : "now running...ヾ(⌒(_*'ω'*)_",
                \   'runner' : 'vimproc',
                \   'runner/vimproc/updatetime' : 60
                \ },
                \ 'cpp' : {
                \   'type' : 'cpp/g++',
                \ },
                \ 'cpp/clang++' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'cpp/g++' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'fortran' : {
                \   'type' : 'fortran/gfortran',
                \ },
                \ 'fortran/gfortran' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'go' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'haskell' : {
                \   'type' : 'haskell/runghc',
                \ },
                \ 'haskell/ghc' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'haskell/runghc' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'lisp' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'make' : {
                \   'command' : 'make',
                \   'exec' : '%c %o',
                \   'runner' : 'vimproc',
                \ },
                \ 'markdown' : {
                \   'type' : 'markdown/pandoc',
                \   'outputter' : 'browser',
                \ },
                \ 'python' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'ruby' : {
                \   'hook/time/enable' : 1,
                \ },
                \ 'tex' : {
                \   'command' : 'latexmk',
                \   'exec' : ['%c %o %s'],
                \ },
                \ 'watchdogs_checker/_' : {
                \   'outputter' : 'quickfix',
                \   'runner/vimproc/updatetime' : 40,
                \ },
                \}
endfunction

function! s:init_quickrun_hook_post_source() abort
    nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
    augroup vimrc-forQuickRun
        autocmd!
        autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&filetype')) == 'quickrun' | q | endif
    augroup END
endfunction

function! s:init_watchdogs_hook_add() abort
    call watchdogs#setup(g:quickrun_config)

    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_BufWritePost_enables = {
                \}
    let g:watchdogs_check_CursorHold_enable = 0
    let g:watchdogs_check_CursorHold_enables = {
                \}
endfunction

function! s:init_lexima_hook_post_source() abort
    let g:lexima_no_default_rules = 0
    let g:lexima_map_escape = ''
    call lexima#set_default_rules()

    let g:lexima_enable_basic_rules = 1
    let g:lexima_enable_newline_rules = 1
    let g:lexima_enable_space_rules = 1
    let g:lexima_enable_endwise_rules = 1

    " TeX
    call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*%\s.*\%#', 'input': '<CR>% ', 'filetype': ['tex','plaintex']})

    " Fortran
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*if\>.*then\%#', 'input_after': '<CR>end if', 'filetype': ['fortran']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*do.*\%#', 'input_after': '<CR>end do', 'filetype': ['fortran']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*select\s*case\s*.*\%#', 'input_after': '<CR>end select', 'filetype': ['fortran']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*!\s.*\%#', 'input': '<CR>! ', 'filetype': ['fortran']})

    " IDL
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*if\>.*then\s*begin\%#', 'input_after': '<CR>endif', 'filetype': ['idlang']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*endif\s*else\s*begin\%#', 'input_after': '<CR>endelse', 'filetype': ['idlang']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*for\s*\>.*do\s*begin\%#', 'input_after': '<CR>endfor', 'filetype': ['idlang']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*case\>.*of\%#', 'input_after': '<CR>endcase', 'filetype': ['idlang']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*\;\s.*\%#', 'input': '<CR>; ', 'filetype': ['idlang']})
endfunction

function! s:init_gitgutter_hook_add() abort
    let g:gitgutter_max_signs = 10000
    let g:gitgutter_map_keys = 0
    let g:gitgutter_sign_added = '✚'
    let g:gitgutter_sign_modified = '➜'
    let g:gitgutter_sign_removed = '✘'
endfunction

function! s:init_gundo_hook_add() abort
    nnoremap <F5> :<C-u>GundoToggle<CR>
endfunction

function! s:init_gundo_hook_source() abort
    let g:gundo_width = 45
    let g:gundo_preview_height = 15
    let g:gundo_right = 0
    let g:gundo_help = 1
    let g:gundo_map_move_older = "j"
    let g:gundo_map_move_newer = "k"
    let g:gundo_close_on_revert = 1
    let g:gundo_auto_preview = 1
    let g:gundo_playback_delay = 100
endfunction

function! s:init_nerdtree_hook_add() abort
    nnoremap <F6> :<C-u>NERDTreeToggle<CR>
endfunction

function! s:init_nerdtree_hook_source() abort
    augroup vimrc-nerdtree
        autocmd!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    augroup END
endfunction

function! s:init_yankround_hook_add() abort
    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap gp <Plug>(yankround-gp)
    nmap gP <Plug>(yankround-gP)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)
endfunction

function! s:init_yankround_hook_source() abort
    let g:yankround_max_history = 35
    let g:yankround_use_region_hl = 1
endfunction

function! s:init_asterisk_hook_add() abort
    map *   <Plug>(asterisk-*)
    map #   <Plug>(asterisk-#)
    map g*  <Plug>(asterisk-g*)
    map g#  <Plug>(asterisk-g#)
    map z*  <Plug>(asterisk-z*)
    map gz* <Plug>(asterisk-gz*)
    map z#  <Plug>(asterisk-z#)
    map gz# <Plug>(asterisk-gz#)
endfunction

function! s:init_incsearch_hook_add() abort
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <plug>(incsearch-stay)
endfunction

function! s:init_anzu_hook_add() abort
    nmap n <Plug>(anzu-n)zz
    nmap N <Plug>(anzu-N)zz
    nmap * <Plug>(anzu-star)zz
    nmap # <Plug>(anzu-sharp)zz
    augroup vimrc-anzu
        autocmd!
        autocmd CursorHold,CursorHoldI,WinLeave,Tableave * call anzu#clear_search_status()
    augroup END
endfunction

function! s:init_visualstar_hook_add() abort
    map * <Plug>(visualstar-*)
    map # <Plug>(visualstar-#)
    map g* <Plug>(visualstar-g*)
    map g# <Plug>(visualstar-g#)
endfunction

function! s:init_cleverf_hook_add() abort
    let g:clever_f_not_overwrites_standard_mappings = 1
    let g:clever_f_across_no_line = 0
    let g:clever_f_ignore_case = 0
    let g:clever_f_smart_case = 0
    let g:clever_f_use_migemo = 1
    let g:clever_f_fix_key_direction = 0
    let g:clever_f_show_prompt = 0
    let g:clever_f_chars_match_any_signs = ''
    let g:clever_f_mark_cursor = 1
    let g:clever_f_mark_cursor_color = 'Cursor'
    let g:clever_f_hide_cursor_on_cmdline = 1
    let g:clever_f_timeout_ms = 0
    let g:clever_f_mark_char = 1
    let g:clever_f_mark_char_color = 'CleverFDefaultLabel'
    let g:clever_f_repeat_last_char_inputs = ["\<CR>"]

    nmap <Plug>(arpeggio-default:f) <Plug>(clever-f-f)
    nmap F <Plug>(clever-f-F)
    nmap t <Plug>(clever-f-t)
    nmap T <Plug>(clever-f-T)
endfunction

function! s:init_jplus_hook_add() abort
    nmap J <Plug>(jplus)
    vmap J <Plug>(jplus)

    nmap <Leader>J <Plug>(jplus-getchar)
    vmap <Leader>J <Plug>(jplus-getchar)

    let g:jplus#config = {
                \ 'sh' : {
                \   'left_matchstr_pattern' : '^.\{-}\%(\ze\s*\\$\|$\)',
                \   'ignore_pattern' : '^\s*#',
                \ },
                \ 'vim' : {
                \   'ignore_pattern' : '^\s*"',
                \ },
                \}

    let g:jplus#input_config = {
                \ '__DEFAULT__' : {
                \   'delimiter_format' : ' %d ',
                \ },
                \ ',' : {
                \   'delimiter_format' : '%d ',
                \ },
                \}
endfunction

function! s:init_quickhl_hook_add() abort
    nmap <Space>m <Plug>(quickhl-manual-this)
    xmap <Space>m <Plug>(quickhl-manual-this)
    nmap <Space>M <Plug>(quickhl-manual-reset)
    xmap <Space>M <Plug>(quickhl-manual-reset)
endfunction

function! s:init_niji_hook_source() abort
    let g:niji_matching_filetypes = [
                \ 'lisp',
                \ 'scheme',
                \ 'clojure',
                \ ]
endfunction

"operator

function! s:init_operator_replace_hook_add() abort
    Arpeggio map or <Plug>(operator-replace)
endfunction

function! s:init_operator_comment_hook_add() abort
    Arpeggio map oc <Plug>(operator-comment)
    Arpeggio map od <Plug>(operator-uncomment)
endfunction

function! s:init_operator_surround_hook_add() abort
    map Sa <Plug>(operator-surround-append)
    map Sd <Plug>(operator-surround-delete)
    map Sr <Plug>(operator-surround-replace)
endfunction


"textobj
function! s:init_textobj_jabraces_hook_add() abort
    let g:textobj_jabraces_no_default_key_mappings = 1

    omap aj( <Plug>(textobj-jabraces-parens-a)
    omap aj) <Plug>(textobj-jabraces-parens-a)
    omap ij( <Plug>(textobj-jabraces-parens-i)
    omap ij) <Plug>(textobj-jabraces-parens-i)
    vmap aj( <Plug>(textobj-jabraces-parens-a)
    vmap aj) <Plug>(textobj-jabraces-parens-a)
    vmap ij( <Plug>(textobj-jabraces-parens-i)
    vmap ij) <Plug>(textobj-jabraces-parens-i)

    omap ajk <Plug>(textobj-jabraces-kakko-a)
    omap ijk <Plug>(textobj-jabraces-kakko-i)
    vmap ajk <Plug>(textobj-jabraces-kakko-a)
    vmap ijk <Plug>(textobj-jabraces-kakko-i)

    omap ajK <Plug>(textobj-jabraces-double-kakko-a)
    omap ijK <Plug>(textobj-jabraces-double-kakko-i)
    vmap ajK <Plug>(textobj-jabraces-double-kakko-a)
    vmap ijK <Plug>(textobj-jabraces-double-kakko-i)

    omap ajs <Plug>(textobj-jabraces-sumi-kakko-a)
    omap ijs <Plug>(textobj-jabraces-sumi-kakko-i)
    vmap ajs <Plug>(textobj-jabraces-sumi-kakko-a)
    vmap ijs <Plug>(textobj-jabraces-sumi-kakko-i)
endfunction

function! s:init_textobj_multiblock_hook_add() abort
    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    vmap ab <Plug>(textobj-multiblock-a)
    vmap ib <Plug>(textobj-multiblock-i)
endfunction

function! s:init_textobj_multitextobj_hook_add() abort
    let g:textobj_multitextobj_textobjects_i = [
                \   '<Plug>(textobj-url-i)',
                \   '<Plug>(textobj-multiblock-i)',
                \   '<Plug>(textobj-function-i)',
                \   '<Plug>(textobj-entire-i)',
                \]
    let g:textobj_multitextobj_textobjects_a = [
                \   '<Plug>(textobj-url-a)',
                \   '<Plug>(textobj-multiblock-a)',
                \   '<Plug>(textobj-function-a)',
                \   '<Plug>(textobj-entire-a)',
                \]
    omap amt <Plug>(textobj-multitextobj-a)
    omap imt <Plug>(textobj-multitextobj-i)
    vmap amt <Plug>(textobj-multitextobj-a)
    vmap imt <Plug>(textobj-multitextobj-i)

    let g:textobj_multitextobj_textobjects_group_i = {
                \ 'A' : [
                \   '<Plug>(textobj-jabraces-sumi-kakko-i)',
                \   '<Plug>(textobj-jabraces-parens-i)',
                \   '<Plug>(textobj-jabraces-kakko-i)',
                \   '<Plug>(textobj-jabraces-double-kakko-i)',
                \ ],
                \}
    let g:textobj_multitextobj_textobjects_group_a = {
                \ 'A' : [
                \   '<Plug>(textobj-jabraces-sumi-kakko-a)',
                \   '<Plug>(textobj-jabraces-parens-a)',
                \   '<Plug>(textobj-jabraces-kakko-a)',
                \   '<Plug>(textobj-jabraces-double-kakko-a)',
                \ ],
                \}
    map <Plug>(textobj-multitextobj-jabraces-i) <Plug>(textobj-multitextobj-A-i)
    map <Plug>(textobj-multitextobj-jabraces-a) <Plug>(textobj-multitextobj-A-a)
    omap ajb <Plug>(textobj-multitextobj-jabraces-a)
    omap ijb <Plug>(textobj-multitextobj-jabraces-i)
    vmap ajb <Plug>(textobj-multitextobj-jabraces-a)
    vmap ijb <Plug>(textobj-multitextobj-jabraces-i)
endfunction

function! s:init_textobj_ruby_hook_source() abort
    let g:textobj_ruby_more_mappings = 1
endfunction

function! s:init_capture_hook_source() abort
    augroup vimrc-capture
        autocmd!
        autocmd FileType capture nnoremap <buffer><silent>q :<C-u>q<CR>
        autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&filetype')) == 'capture' | q | endif
    augroup END
endfunction

function! s:init_openbrowser_hook_add() abort
    if has('mac')
        let g:openbrowser_browser_commands = [
                    \{
                    \ 'name' : 'open',
                    \ 'args' : ['{browser}', '{uri}']
                    \}]
    elseif has('unix')
        let g:openbrowser_browser_commands = [
                    \{
                    \ 'name' : 'chromium',
                    \ 'args' : ['{browser}', '{uri}']
                    \}]
    endif

    let g:openbrowser_search_engines = extend(
                \get(g:, 'openbrowser_search_engines', {}),
                \{
                \ 'weblio' : 'http://ejje.weblio.jp/content/{query}',
                \},
                \)

    nmap ,op <Plug>(openbrowser-smart-search)
    vmap ,op <Plug>(openbrowser-smart-search)

    nnoremap <silent> ,ow :<C-u>OpenBrowserSearch -weblio <C-r><C-w><CR>
    nnoremap <silent> ,oa :<C-u>OpenBrowserSearch -alc <C-r><C-w><CR>

    call altercmd#define('google', 'OpenBrowserSearch -google')
    call altercmd#define('weblio', 'OpenBrowserSearch -weblio')
    call altercmd#define('alc', 'OpenBrowserSearch -alc')
endfunction

function! s:init_vim2hs_hook_source() abort
    let g:haskell_conceal = 0
    let g:haskell_conceal_wide = 0
    let g:haskell_conceal_enumerations = 0
endfunction

function! s:init_ref_hook_add() abort
    let g:ref_source_webdict_sites = {
                \ 'je' : {
                \   'url' : 'http://dictionary.infoseek.ne.jp/jeword/%s',
                \ },
                \ 'ej' : {
                \   'url' : 'http://dictionary.infoseek.ne.jp/ejword/%s',
                \ },
                \ 'wiki' : {
                \   'url' : 'http://ja.wikipedia.org/wiki/%s',
                \ },
                \}
    let g:ref_source_webdict_sites.default = 'ej'
    function! g:ref_source_webdict_sites.je.filter(output)
        return join(split(a:output, "\n")[15 :], "\n")
    endfunction
    function! g:ref_source_webdict_sites.ej.filter(output)
        return join(split(a:output, "\n")[15 :], "\n")
    endfunction
    function! g:ref_source_webdict_sites.wiki.filter(output)
        return join(split(a:output, "\n")[5 :], "\n")
    endfunction

    augroup vimrc-ref
        autocmd!
        autocmd FileType ref-* nnoremap <buffer><silent>q :<C-u>q<CR>
    augroup END

    nnoremap [ref] <Nop>
    nmap ,r [ref]
    nnoremap <silent> [ref]ej :<C-u>Ref webdict ej <C-r><C-w><CR>
    nnoremap <silent> [ref]je :<C-u>Ref webdict je <C-r><C-w><CR>
    nnoremap <silent> [ref]wk :<C-u>Ref webdict wiki <C-r><C-w><CR>

    call altercmd#define('ejdic', 'Ref webdict ej')
    call altercmd#define('jedic', 'Ref webdict je')
    call altercmd#define('wiki',  'Ref webdict wiki')
endfunction

function! s:init_tweetvim_hook_source() abort
    let g:tweetvim_tweet_per_page = 50
    let g:tweetvim_display_icon = 0
endfunction

function! s:init_j6uil_hook_source() abort
    let g:J6uil_user = 'rinx'
endfunction

function! s:init_gista_hook_source() abort
    let g:gista#github_user = 'rinx'
endfunction

function! s:init_shaberu_hook_source() abort
    let g:shaberu_use_voicetext_api = 1
    if exists('g:vimrc_private["shaberu_voicetext_apikey"]')
        let g:shaberu_voicetext_apikey = g:vimrc_private['shaberu_voicetext_apikey']
    endif
    let g:shaberu_voicetext_speaker = 'hikari'
endfunction

function! s:init_radiko_hook_add() abort
    let g:radiko#cache_dir = expand("~/.cache/radiko-vim")

    function! s:radiko_echo_rn2_musics()
        let playing = radiko#get_playing_rn2_music()
        let nextone = radiko#get_next_rn2_music()
        return '[Now playing]: ' . playing[0] . ' - ' . playing[1]
                    \ . ' [Next]: ' . nextone[0] . ' - ' . nextone[1]
    endfunction
    command! RadikoRN2Musics echo <SID>radiko_echo_rn2_musics()
endfunction

function! s:init_submode_hook_add() abort
    call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
    call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
    call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
    call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
    call submode#map('bufmove', 'n', '', '>', '<C-w>>')
    call submode#map('bufmove', 'n', '', '<', '<C-w><')
    call submode#map('bufmove', 'n', '', '+', '<C-w>+')
    call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endfunction


" --- load plugin settings ---

if has('vim_starting')
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

call dein#begin(expand('~/.vim/dein/'))

"github repositories
call dein#add('Shougo/dein.vim')

call dein#add('haya14busa/dein-command.vim')
call dein#config('dein-command.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Dein',
            \ ],
            \})

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif

call dein#add('Shougo/vimproc.vim')
call dein#config('vimproc.vim', {
            \ 'build': 'make',
            \})

call dein#add('Shougo/neocomplete.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_neocomplete_hook_add()',
            \ })
call dein#config('neocomplete.vim', {
            \ 'lazy': 1,
            \ 'on_i': 1,
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_neocomplete_hook_source()',
            \})

call dein#add('ujihisa/neco-look')
call dein#config('neco-look', {
            \ 'lazy' : 1,
            \ 'on_ft' : [
            \     'markdown',
            \ ],
            \})

call dein#add('Shougo/neosnippet', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_neosnippet_hook_add()',
            \})
call dein#config('neosnippet', {
            \ 'lazy': 1,
            \ 'on_i' : 1,
            \ 'on_ft' : [
            \     'neosnippet',
            \ ],
            \})
call dein#add('Shougo/neosnippet-snippets')
call dein#config('neosnippet-snippets', {
            \ 'lazy': 1,
            \ 'on_i': 1,
            \})
call dein#add('honza/vim-snippets')
call dein#config('vim-snippets', {
            \ 'lazy': 1,
            \ 'on_i': 1,
            \})

call dein#add('Shougo/vimfiler.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_vimfiler_hook_add()',
            \})
call dein#config('vimfiler.vim', {
            \ 'lazy': 1,
            \ 'on_cmd' : [
            \   'VimFilerTab',
            \   'VimFiler',
            \   'VimFilerExplorer',
            \ ],
            \})
call dein#add('Shougo/vimshell.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_vimshell_hook_add()',
            \})
call dein#config('vimshell.vim', {
            \ 'lazy': 1,
            \ 'on_cmd' : [
            \   'VimShell',
            \   'VimShellPop',
            \   'VimShellInteractive',
            \ ],
            \})

call dein#add('kana/vim-submode', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_submode_hook_add()',
            \})
call dein#add('kana/vim-arpeggio', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_arpeggio_hook_add()',
            \})
call dein#add('kana/vim-altercmd')

call dein#add('Shougo/unite.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_unite_hook_add()',
            \})
call dein#config('unite.vim', {
            \ 'lazy': 1,
            \ 'on_cmd' : [
            \   'Unite',
            \   'UniteWithBufferDir',
            \   'UniteWithCurrentDir',
            \   'UniteResume',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_unite_hook_source()',
            \})
call dein#add('Shougo/neomru.vim')
call dein#config('neomru.vim', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('thinca/vim-unite-history')
call dein#config('vim-unite-history', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('Shougo/unite-outline')
call dein#config('unite-outline', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('tsukkee/unite-help')
call dein#config('unite-help', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('osyo-manga/unite-filetype')
call dein#config('unite-filetype', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('kmnk/vim-unite-giti')
call dein#config('vim-unite-giti', {
            \ 'lazy': 1,
            \ 'on_cmd' : [
            \   'Giti',
            \   'GitiWithConfirm',
            \   'GitiFetch',
            \   'GitiPush',
            \   'GitiPushWithSettingUpstream',
            \   'GitiPushExpressly',
            \   'GitiPull',
            \   'GitiPullSquash',
            \   'GitiPullRebase',
            \   'GitiPullExpressly',
            \   'GitiDiff',
            \   'GitiDiffCached',
            \   'GitiLog',
            \   'GitiLogLine',
            \ ],
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('tacroe/unite-mark')
call dein#config('unite-mark', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('moznion/unite-git-conflict.vim')
call dein#config('unite-git-conflict.vim', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('haya14busa/unite-reading-vimrc')
call dein#config('unite-reading-vimrc', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('pasela/unite-webcolorname')
call dein#config('unite-webcolorname', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})

call dein#add('itchyny/lightline.vim')

let s:enable_eskk = 0
if s:enable_eskk
    call dein#add('tyru/eskk.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_eskk_hook_add()',
                \})
else
    call dein#add('tyru/skk.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_skk_hook_add()',
                \})
endif

call dein#add('thinca/vim-quickrun', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_quickrun_hook_add()',
            \})
call dein#config('vim-quickrun', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'QuickRun',
            \ ],
            \ 'on_map': [
            \   '<Plug>(quickrun',
            \ ],
            \ 'hook_post_source': 'call ' . s:SID_PREFIX() . 'init_quickrun_hook_post_source()',
            \})
call dein#add('osyo-manga/unite-quickrun_config')
call dein#config('unite-quickrun_config', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})

call dein#add('osyo-manga/shabadou.vim')
call dein#add('osyo-manga/vim-watchdogs', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_watchdogs_hook_add()',
            \})
call dein#add('jceb/vim-hier')
call dein#config('vim-hier', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'HierStart',
            \   'HierStop',
            \   'HierUpdate',
            \   'HierClear',
            \ ],
            \})

call dein#add('ynkdir/vim-vimlparser')
call dein#add('syngan/vim-vimlint')

call dein#add('vim-scripts/eregex.vim')

call dein#add('tmhedberg/matchit')

call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-repeat')

call dein#add('cohama/lexima.vim')
call dein#config('lexima.vim', {
            \ 'lazy': 1,
            \ 'on_i': 1,
            \ 'hook_post_source': 'call ' . s:SID_PREFIX() . 'init_lexima_hook_post_source()',
            \})

call dein#add('airblade/vim-gitgutter', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_gitgutter_hook_add()',
            \})

call dein#add('sjl/gundo.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_gundo_hook_add()',
            \})
call dein#config('gundo.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'GundoToggle',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_gundo_hook_source()',
            \})
call dein#add('scrooloose/nerdtree', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_nerdtree_hook_add()',
            \})
call dein#config('nerdtree', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'NERDTree',
            \   'NERDTreeFromBookmark',
            \   'NERDTreeToggle',
            \   'NERDTreeMirror',
            \   'NERDTreeClose',
            \   'NERDTreeFind',
            \   'NERDTreeCWD',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_nerdtree_hook_source()',
            \})

call dein#add('LeafCage/yankround.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_yankround_hook_add()',
            \})
call dein#config('yankround.vim', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(yankround-',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_yankround_hook_source()',
            \})

call dein#add('haya14busa/vim-asterisk', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_asterisk_hook_add()',
            \})
call dein#config('vim-asterisk', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(asterisk-',
            \ ],
            \})
call dein#add('haya14busa/incsearch.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_incsearch_hook_add()',
            \})
call dein#config('incsearch.vim', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(incsearch-',
            \ ],
            \})
call dein#add('haya14busa/vim-migemo')

call dein#add('osyo-manga/vim-anzu', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_anzu_hook_add()',
            \})
call dein#config('vim-anzu', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(anzu-',
            \ ],
            \})
call dein#add('osyo-manga/vim-over')
call dein#add('thinca/vim-visualstar', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_visualstar_hook_add()',
            \})
call dein#config('vim-visualstar', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(visualstar-',
            \ ],
            \})

call dein#add('rhysd/clever-f.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_cleverf_hook_add()',
            \})
call dein#add('osyo-manga/vim-jplus', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_jplus_hook_add()',
            \})

call dein#add('thinca/vim-qfreplace')
call dein#config('vim-qfreplace', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Qfreplace',
            \ ],
            \})

call dein#add('t9md/vim-quickhl', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_quickhl_hook_add()',
            \})
call dein#config('vim-quickhl', {
            \ 'lazy': 1,
            \ 'on_map': [
            \   '<Plug>(quickhl-',
            \ ],
            \})

call dein#add('spinningarrow/vim-niji')
call dein#config('vim-niji', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'lisp',
            \   'scheme',
            \   'clojure',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_niji_hook_source()',
            \})

call dein#add('kana/vim-operator-user')
call dein#add('kana/vim-operator-replace', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_operator_replace_hook_add()',
            \})
call dein#add('emonkak/vim-operator-comment', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_operator_comment_hook_add()',
            \})
call dein#add('rhysd/vim-operator-surround', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_operator_surround_hook_add()',
            \})

call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-indent')
call dein#add('kana/vim-textobj-function')
call dein#add('kana/vim-textobj-entire')
call dein#add('kana/vim-textobj-line')
call dein#add('kana/vim-textobj-jabraces', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_jabraces_hook_add()',
            \})
call dein#add('lucapette/vim-textobj-underscore')
call dein#add('mattn/vim-textobj-url')
call dein#add('osyo-manga/vim-textobj-multiblock', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_multiblock_hook_add()',
            \})
call dein#add('osyo-manga/vim-textobj-multitextobj', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_multitextobj_hook_add()',
            \})
call dein#add('rhysd/vim-textobj-ruby')
call dein#config('vim-textobj-ruby', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'ruby',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_textobj_ruby_hook_source()',
            \})

call dein#add('tyru/capture.vim')
call dein#config('capture.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Capture',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_capture_hook_source()',
            \})

call dein#add('tyru/open-browser.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_openbrowser_hook_add()',
            \})
call dein#config('open-browser.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'OpenBrowser',
            \   'OpenBrowserSearch',
            \ ],
            \ 'on_func': [
            \   'openbrowser',
            \ ],
            \ 'on_ft': [
            \   'markdown',
            \ ],
            \ 'on_map': [
            \   '<Plug>(openbrowser-',
            \ ],
            \})
call dein#add('tyru/open-browser-github.vim')
call dein#config('open-browser-github.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'OpenGithubFile',
            \   'OpenGithubIssue',
            \   'OpenGithubPullReq',
            \ ],
            \})

call dein#add('kannokanno/previm')
call dein#config('previm', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'markdown',
            \ ],
            \ 'on_cmd': [
            \   'PrevimOpen',
            \ ],
            \})

call dein#add('basyura/unite-rails')
call dein#config('unite-rails', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'ruby',
            \ ],
            \})

call dein#add('eagletmt/ghcmod-vim')
call dein#config('ghcmod-vim', {
            \ 'lazy': 1,
            \ 'on_ft' : [
            \   'haskell',
            \ ],
            \})
call dein#add('eagletmt/neco-ghc')
call dein#config('neco-ghc', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'haskell',
            \ ],
            \})
call dein#add('dag/vim2hs')
call dein#config('vim2hs', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'haskell',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_vim2hs_hook_source()',
            \})
call dein#add('ujihisa/ref-hoogle')
call dein#config('ref-hoogle', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'haskell',
            \ ],
            \})
call dein#add('ujihisa/unite-haskellimport')
call dein#config('unite-haskellimport', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})
call dein#add('pbrisbin/html-template-syntax')
call dein#config('html-template-syntax', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'hamlet',
            \   'cassius',
            \   'lucius',
            \   'julius',
            \ ],
            \ 'on_path': [
            \   '.*.hamlet$',
            \   '.*.cassius$',
            \   '.*.lucius$',
            \   '.*.julius$',
            \ ],
            \})

call dein#add('google/vim-ft-go')
call dein#config('vim-ft-go', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'go',
            \ ],
            \})
call dein#add('vim-jp/vim-go-extra')
call dein#config('vim-go-extra', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'go',
            \ ],
            \})

call dein#add('mattn/emmet-vim')
call dein#config('emmet-vim', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'html',
            \   'xhtml',
            \   'css',
            \   'sass',
            \   'scss',
            \   'xml',
            \   'markdown',
            \ ],
            \})

call dein#add('elzr/vim-json')
call dein#config('vim-json', {
            \ 'lazy': 1,
            \ 'on_ft': [
            \   'json',
            \   'jsonp',
            \ ],
            \ 'on_path': [
            \   '.*.json$',
            \   '.*.jsonp$',
            \ ],
            \})

call dein#add('Shougo/vinarise.vim')
call dein#config('vinarise.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Vinarise',
            \   'VinariseScript2Hex',
            \   'VinariseHex2Script',
            \   'VinarisePluginDump',
            \   'VinarisePluginViewBitmapView',
            \ ],
            \})

call dein#add('thinca/vim-ref', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_ref_hook_add()',
            \})
call dein#config('vim-ref', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Ref',
            \ ],
            \ 'on_map': [
            \   '<Plug>(ref-',
            \ ],
            \})
call dein#add('mattn/learn-vimscript')
call dein#config('learn-vimscript', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'help',
            \ ],
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \})

call dein#add('mattn/webapi-vim')
call dein#add('moznion/hateblo.vim')
call dein#config('hateblo.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'HatebloCreate',
            \   'HatebloCreateDraft',
            \   'HatebloList',
            \   'HatebloUpdate',
            \   'HatebloDelete',
            \ ],
            \})
call dein#add('basyura/twibill.vim')
call dein#add('basyura/TweetVim')
call dein#config('TweetVim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'TweetVimVersion',
            \   'TweetVimAddAccount',
            \   'TweetVimSwitchAccount',
            \   'TweetVimHomeTimeline',
            \   'TweetVimMentions',
            \   'TweetVimListStatuses',
            \   'TweetVimUserTimeline',
            \   'TweetVimSay',
            \   'TweetVimUserStream',
            \   'TweetVimCommandSay',
            \   'TweetVimCurrentLineSay',
            \   'TweetVimSearch',
            \ ],
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_tweetvim_hook_source()',
            \})
call dein#add('basyura/bitly.vim')
call dein#add('mattn/favstar-vim')
call dein#add('basyura/J6uil.vim')
call dein#config('J6uil.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'J6uil',
            \   'J6uilReconnect',
            \   'J6uilDisconnect',
            \ ],
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_j6uil_hook_source()',
            \})

call dein#add('lambdalisue/vim-gista')
call dein#config('vim-gista', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Gista',
            \ ],
            \ 'on_map': [
            \   '<Plug>(gista-',
            \ ],
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_gista_hook_source()',
            \})

call dein#add('koron/codic-vim')
call dein#config('codic-vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Codic',
            \ ],
            \ 'on_source' : [
            \   'unite.vim',
            \ ],
            \})
call dein#add('rhysd/unite-codic.vim')
call dein#config('unite-codic.vim', {
            \ 'lazy': 1,
            \ 'on_source' : [
            \   'unite.vim',
            \ ],
            \})

call dein#add('supermomonga/shaberu.vim')
call dein#config('shaberu.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'ShaberuSay',
            \   'ShaberuSayInteractive',
            \   'ShaberuSayRecursive',
            \   'ShaberuMuteOn',
            \   'ShaberuMuteOff',
            \   'ShaberuMuteToggle',
            \ ],
            \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_shaberu_hook_source()',
            \})

call dein#add('rinx/radiko.vim', {
            \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_radiko_hook_add()',
            \})
call dein#config('radiko.vim', {
            \ 'lazy': 1,
            \ 'on_source': [
            \   'unite.vim',
            \ ],
            \ 'on_cmd': [
            \   'RadikoPlay',
            \   'RadikoUpdateStations',
            \   'RadikoStop',
            \ ],
            \ 'on_func': [
            \   'radiko',
            \ ],
            \})

call dein#add('tomasr/molokai')

call dein#add('vim-jp/vital.vim')
call dein#config('vital.vim', {
            \ 'lazy': 1,
            \ 'on_cmd': [
            \   'Vitalize',
            \ ],
            \})

call dein#end()


" --- Basic Settings ---

"history
set viminfo='1000,<100,f1,h,s100
set history=300

set bs=indent,eol,start

set ruler
set number
set cursorline
"set cursorcolumn
set cmdheight=2
set wildmenu
set wildchar=<Tab>

set imdisable

"search
set incsearch
set ignorecase
set smartcase

"indent
filetype plugin indent on
set autoindent
set smartindent

"unsaved buffer warning
set confirm

"clipboard
set clipboard+=unnamed,autoselect

"mouse
set mouse=a
set ttymouse=xterm2

"fold
set foldmethod=marker

"visual select
set virtualedit=block

"tab
set expandtab
"set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

if &term=="xterm"
    set t_Co=256
    set t_Sb=[4%dm
    set t_Sf=[3%dm
endif

set visualbell
set lazyredraw
set ttyfast

"for session
set sessionoptions+=tabpages

"showmatch
set showmatch
set matchtime=3

if v:version >= 703
    set cryptmethod=blowfish
    set conceallevel=0
endif

"backup
set backup

set undofile
set undolevels=1000
set undoreload=10000

set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo
set directory=~/.vim/tmp/swap

if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

"show tab, newline, etc...
set list
set listchars=eol:¬,tab:▸\ ,extends:>,precedes:<,trail:-

set noautochdir
set autoread
set noautowrite


" --- Color settings ---

syntax enable
if !exists('g:colors_name')
    set background=dark
    colorscheme molokai 
endif

hi Normal ctermbg=none


" --- functions ---

"A function to convert csv to markdown table
function! s:csv_to_markdown_table () range
    let lines = getline(a:firstline, a:lastline)
    let linecount = a:lastline - a:firstline
    let spacelen = []
    let maxrownum = 0
    let maxcollen = []
    let values = []
    for i in range(0, linecount)
        let linespacelen = []
        call add(values, split(substitute(lines[i], '\s*\,\s*', ',', 'g'), ','))
        for v in values[i]
            call add(linespacelen, len(v))
        endfor
        if len(values[i]) > maxrownum
            let maxrownum = len(values[i])
        endif
        call add(spacelen, linespacelen)
        unlet linespacelen
    endfor
    for i in range(0, linecount)
        while len(spacelen[i]) < maxrownum
            call add(spacelen[i], 0)
        endwhile
    endfor
    for i in range(0, maxrownum - 1)
        call add(maxcollen, 0)
        for j in range(0, linecount)
            if spacelen[j][i] > maxcollen[i]
                let maxcollen[i] = spacelen[j][i]
            endif
        endfor
    endfor
    for i in range(0, linecount)
        let aftersbst = ""
        for j in range(0, len(values[i]) - 1)
            let aftersbst .= "| " . values[i][j] . repeat(" ", maxcollen[j] - len(values[i][j])) . " "
        endfor
       call setline(i + a:firstline, aftersbst . "|")
    endfor
    let secondline = ""
    for i in range(0, len(values[0]) - 1)
        let secondline .= "|:" . repeat("-", maxcollen[i]) . ":"
    endfor
    call append(a:firstline, secondline . "|")
endfunction

command! -range CsvToMarkdownTable <line1>,<line2>call s:csv_to_markdown_table()

"A function to convert csv to tex table
function! s:csv_to_tex_table() range
    let lines = getline(a:firstline, a:lastline)
    let spacelen = []
    let maxrownum = 0
    let maxcollen = []
    let values = []
    for i in range(0, a:lastline - a:firstline)
        let linespacelen = []
        call add(values, split(substitute(lines[i], '\s*\,\s*', ',', 'g'), ','))
        for v in values[i]
            call add(linespacelen, len(v))
        endfor
        if len(values[i]) > maxrownum
            let maxrownum = len(values[i])
        endif
        call add(spacelen, linespacelen)
        unlet linespacelen
    endfor
    for i in range(0, a:lastline - a:firstline)
        while len(spacelen[i]) < maxrownum
            call add(spacelen[i], 0)
        endwhile
    endfor
    for i in range(0, maxrownum - 1)
        call add(maxcollen, 0)
        for j in range(0, a:lastline - a:firstline)
            if spacelen[j][i] > maxcollen[i]
                let maxcollen[i] = spacelen[j][i]
            endif
        endfor
    endfor
    for i in range(0, a:lastline - a:firstline)
        let aftersbst = values[i][0] . repeat(" ", maxcollen[0] - len(values[i][0])) . " "
        for j in range(1, len(values[i]) - 1)
            let aftersbst .= "& " . values[i][j] . repeat(" ", maxcollen[j] - len(values[i][j])) . " "
        endfor
       call setline(i + a:firstline, aftersbst . "\\\\")
    endfor
endfunction

command! -range CsvToTexTable <line1>,<line2>call s:csv_to_tex_table()


" Make new window for Japanese input via skk.vim
" !!This should be improved!!
function! s:make_japanese_input_window()
    let newbufname = 'input_via_skk'
    silent! execute 'new' newbufname

    if has('mac')
        let _ = 'w !pbcopy'
    elseif has('unix')
        let _ = 'w !xsel --clipboard --input'
    endif

    silent! execute 'inoremap <buffer> <CR> <Esc>:' . _ . '<CR>dd'
    silent! execute 'nnoremap <buffer> <CR> :' . _ . '<CR>dd'
    silent! nnoremap <buffer> q :<C-u>q!<CR>
endfunction

command! MakeJapaneseInputWindow call s:make_japanese_input_window()

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

if $TERM =~ 'screen'
    nnoremap <C-t> <Nop>
endif

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

"nohilight by pressing Esc twice
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

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

" sticky shift
" http://vim-jp.org/vim-users-jp/2009/08/09/Hack-54.html
inoremap <expr> ;  <SID>sticky_func()
cnoremap <expr> ;  <SID>sticky_func()
snoremap <expr> ;  <SID>sticky_func()

function! s:sticky_func()
    let l:sticky_table = {
                \',' : '<', '.' : '>', '/' : '?',
                \'1' : '!', '2' : '@', '3' : '#', '4' : '$', '5' : '%',
                \'6' : '^', '7' : '&', '8' : '*', '9' : '(', '0' : ')', '-' : '_', '=' : '+',
                \';' : ':', '[' : '{', ']' : '}', '`' : '~', "'" : "\"", '\' : '|',
                \}
    let l:special_table = {
                \"\<ESC>" : "\<ESC>", "\<Space>" : ';', "\<CR>" : ";\<CR>"
                \}

    let l:key = getchar()
    if nr2char(l:key) =~ '\l'
        return toupper(nr2char(l:key))
    elseif has_key(l:sticky_table, nr2char(l:key))
        return l:sticky_table[nr2char(l:key)]
    elseif has_key(l:special_table, nr2char(l:key))
        return l:special_table[nr2char(l:key)]
    else
        return ''
    endif
endfunction


" --- filetype settings ---

"golang
set rtp^=$GOROOT/misc/vim
set rtp^=$GOPATH/src/github.com/nsf/gocode/vim
let g:gofmt_command = 'goimports'
augroup vimrc-golang
    autocmd!
    autocmd BufWritePre *.go Fmt
    autocmd BufNewFile,BufRead *.go set sw=4 noexpandtab ts=4
    autocmd FileType go compiler go
augroup END


" --- below this, they are not filetypes but ...

"QuickFix window
augroup vimrc-forQuickFix
    autocmd!
    " mappings
    autocmd FileType qf nnoremap <buffer> j j
    autocmd FileType qf nnoremap <buffer> k k
    autocmd FileType qf nnoremap <buffer> 0 0
    autocmd FileType qf nnoremap <buffer> $ $
    autocmd FileType qf nnoremap <buffer> gj gj
    autocmd FileType qf nnoremap <buffer> gk gk
    autocmd FileType qf nnoremap <buffer> g0 g0
    autocmd FileType qf nnoremap <buffer> g$ g$
    " quit QuickFix with q-key
    autocmd FileType qf nnoremap <buffer><silent>q :<C-u>q<CR>
    " autoclose
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif
augroup END

"Help window
augroup vimrc-forHelpWindow
    autocmd!
    autocmd FileType help nnoremap <buffer><silent>q :<C-u>q<CR>
augroup END


" --- Statusline settings ---

set laststatus=2

let g:lightline = {
            \ 'active': {
            \   'left': [ 
            \             [ 'mode', 'paste' ],
            \             [ 'fugitive', 'filename' ],
            \   ],
            \   'right': [
            \             [ 'lineinfo' ],
            \             [ 'percent' ],
            \             [ 'skkstatus', 'anzu', 'fileformat', 'fileencoding', 'filetype' ],
            \   ],
            \ },
            \ 'component_function': {
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'fugitive': 'MyFugitive',
            \   'filename': 'MyFilename',
            \   'fileformat': 'MyFileformat',
            \   'filetype': 'MyFiletype',
            \   'mode': 'MyMode',
            \   'skkstatus': 'MySkkgetmode',
            \   'anzu': 'anzu#search_status',
            \   'tablineabspath': 'MyAbsPath',
            \   'tabfugitive': 'MyFugitiveInv',
            \   'tabradikosta': 'MyRadikoSta',
            \ },
            \ 'component_expand': {
            \ },
            \ 'component_type': {
            \ },
            \ 'inactive' : {
            \   'left' : [
            \     [ 'filename' ],
            \   ],
            \   'right' : [
            \     [ 'lineinfo' ],
            \   ],
            \ },
            \ 'tabline' : {
            \   'left' : [
            \     [ 'tabs' ],
            \   ],
            \   'right' : [
            \     [ 'tablineabspath', 'tabfugitive', 'tabradikosta' ],
            \   ],
            \ },
            \ }

function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo\|nerdtree\|qf\|quickrun' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vimfiler\|gundo\|nerdtree\|qf\|quickrun' && &ro ? ' ' : ''
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vimfiler\|gundo\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') > 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFugitiveInv()
    try
        if &ft !~? 'vimfiler\|gundo\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') < 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFileformat()
    return winwidth('.') > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
    return &ft == 'vimfiler' ? 'VimFiler' : 
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ &ft == 'qf' ? 'QuickFix' :
                \ &ft == 'quickrun' ? '' :
                \ winwidth('.') > 60 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                \  &ft == 'unite' ? unite#get_status_string() :
                \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
                \  &ft == 'qf' ? len(getqflist()) . ' fixes' :
                \  &ft == 'quickrun' ? 'QuickRun' :
                \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MySkkgetmode()
    if s:enable_eskk
        let _ = eskk#get_mode()
    else
        let _ = SkkGetModeStr()
    endif
    return winwidth('.') > 70 ? strlen(_) ? substitute(_, '\[\|\]', '', 'g') : '' : ''
endfunction

function! MyAbsPath()
    let _ = expand('%:p:h')
    return &ft == 'vimfiler' ? '' :
                \ &ft == 'unite' ? '' :
                \ &ft == 'vimshell' ? '' :
                \ &ft == 'qf' ? '' :
                \ &ft == 'quickrun' ? '' :
                \ tabpagenr('$') > 3 ? '' :
                \ strlen(_) < winwidth('.') / 2 ? _ : ''
endfunction

function! MyRadikoSta()
    if radiko#is_playing()
        let _ = radiko#get_playing_station_id()
        if winwidth('.') > 70
            if _ == 'RN2'
                let m = radiko#get_playing_rn2_music()
                if winwidth('.') > 120
                    let n = radiko#get_next_rn2_music()
                    let _ = strlen(m[0]) ?
                                \ strlen(n[0]) ?
                                \ strlen(expand('%:p:h')) > 40 ?
                                \ m[0] . ' - ' . m[1] :
                                \ '[Now] ' . m[0] . ' - ' . m[1] .
                                \ ' [Next] ' . n[0] . ' - ' . n[1]
                                \ : m[0] . ' - ' . m[1] : ''
                else
                    let _ = strlen(m[0]) ? m[0] . ' - ' . m[1] : ''
                endif
            else
                let _ = radiko#get_playing_station()
            endif
        endif
    else
        let _ = ''
    endif
    return winwidth('.') > 30 ? strlen(_) ? '♪' . _ : '' : ''
endfunction


" --- The end of initialization ---


"auto-toggle of cursorline
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorcolumn
  autocmd CursorHold,CursorHoldI * setlocal cursorline
  autocmd CursorHold,CursorHoldI * setlocal cursorcolumn
augroup END

"when creating new file, if it does not exist directory,
"this function will ask you to create new directory.
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
          \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

"load Session.vim
augroup vimrc-session-vim-auto-load
    autocmd!
    autocmd VimEnter * nested call s:load_session_vim(expand('<afile>:p:h'))
augroup END

function! s:load_session_vim(loc)
    let files = findfile('Session.vim', escape(a:loc, ' ') . ';', -1)
    if !argc()
        for i in reverse(filter(files, 'filereadable(v:val)'))
            if input(printf('Session.vim exists in "%s". Load it? [y/N]', i)) =~? '^y\%[es]$'
                source `=i`
            endif
        endfor
    endif
endfunction

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


