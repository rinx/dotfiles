" ----------------------------------------
" Author: Rintaro Okamura
" URL:    http://rinx.biz
" Source: https://github.com/rinx/dotfiles
" ----------------------------------------

" not vi compatible
if &compatible
    set nocompatible
endif

" encoding
set encoding=utf-8
scriptencoding utf-8

set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,sjis

" Anywhere SID.
function! s:SID_PREFIX()
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

let g:vimrc_private = {}
let s:vimrc_private_filename = '~/.vimrc_private'
if filereadable(expand(s:vimrc_private_filename))
    execute 'source' expand(s:vimrc_private_filename)
else
    call system('touch ' . expand(s:vimrc_private_filename))
endif
unlet s:vimrc_private_filename

let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')

" --- Plugin settings

if has('nvim')
    function! s:init_deoplete_hook_source() abort
        let g:deoplete#enable_at_startup = 1
        let g:deoplete#enable_ignore_case = 1
        let g:deoplete#enable_smart_case = 1
        let g:deoplete#enable_camel_case = 1
        let g:deoplete#enable_reflesh_always = 0
        let g:deoplete#auto_complete_start_length = 2
        let g:deoplete#auto_complete_delay = 0
        let g:deoplete#enable_profile = 0
        let g:deoplete#max_list = 300
        let g:deoplete#max_abbr_width = 100
        let g:deoplete#max_menu_width = 60
        let g:deoplete#auto_refresh_delay = 50

        let g:deoplete#keyword_patterns = {}
        let g:deoplete#keyword_patterns.tex = '\\?[a-zA-Z_]\w*'

        let g:deoplete#omni_patterns = {}
    endfunction

    function! s:init_deoplete_hook_add() abort
        inoremap <expr><S-Tab>  deoplete#manual_complete()
        inoremap <expr><C-x>l   deoplete#manual_complete(['look'])
        inoremap <expr><C-g>    deoplete#undo_completion()
        inoremap <expr><C-l>    deoplete#complete_common_string()
    endfunction
else
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

        let g:neocomplete#enable_auto_close_preview = 1

        let g:neocomplete#text_mode_filetypes = {
                    \ 'hybrid' : 1,
                    \ 'text' : 1,
                    \ 'help' : 1,
                    \ 'tex' : 1,
                    \ 'latex' : 1,
                    \ 'plaintex' : 1,
                    \ 'gitcommit' : 1,
                    \ 'gitrebase' : 1,
                    \ 'vcs-commit' : 1,
                    \ 'markdown' : 1,
                    \ 'mkd' : 1,
                    \ 'textile' : 1,
                    \ 'creole' : 1,
                    \ 'org' : 1,
                    \ 'rdoc' : 1,
                    \ 'mediawiki' : 1,
                    \ 'rst' : 1,
                    \ 'asciidoc' : 1,
                    \ 'pod' : 1,
                    \ 'gita-commit' : 1,
                    \ 'gina-commit' : 1,
                    \}

    endfunction

    function! s:init_neocomplete_hook_add() abort
        inoremap <expr><S-Tab>  neocomplete#start_manual_complete()

        inoremap <expr><C-g>  neocomplete#undo_completion()
        inoremap <expr><C-l>  neocomplete#complete_common_string()

        inoremap <expr><C-x>l neocomplete#start_manual_complete('look')
    endfunction
endif

function! s:init_neosnippet_hook_add() abort
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)

    " Tell Neosnippet about the other snippets
    if has('nvim')
        let reporoot = '~/.config/nvim/dein'
    else
        let reporoot = '~/.vim/dein'
    endif
    let g:neosnippet#snippets_directory = [
                \ expand(reporoot . '/repos/github.com/honza/vim-snippets/snippets'),
                \ expand(reporoot . '/repos/github.com/Shougo/neosnippet-snippets/neosnippets'),
                \ expand('~/.vim/my-snippets'),
                \]
    unlet reporoot

    let g:neosnippet#enable_snipmate_compatibility = 1

    let g:neosnippet#disable_runtime_snippets = {
                \ "_": 1,
                \}

    augroup vimrc-neosnippet
        autocmd FileType neosnippet setlocal noexpandtab
    augroup END
endfunction

function! s:init_vaffle_hook_add() abort
    nnoremap [vaffle] <Nop>
    nmap ,v [vaffle]
    nnoremap <silent> [vaffle] :<C-u>Vaffle<CR>

    let g:vaffle_auto_cd = 0
    let g:vaffle_force_delete = 0
    let g:vaffle_show_hidden_files = 1
    let g:vaffle_use_default_mappings = 1
endfunction

function! s:init_arpeggio_hook_add() abort
    call arpeggio#load()
endfunction

" denite.nvim and unite.vim configures

if has('mac')
    let s:copyToClipboardCommand = 'w !pbcopy'
elseif has('unix')
    let s:copyToClipboardCommand = 'w !xsel --clipboard --input'
endif
let s:unite_denite_shortcut_candidates = [
            \ ['quickrun', 'QuickRun'],
            \ ['make(quickrun)', 'QuickRun make'],
            \ ['watchdogs', 'WatchdogsRun'],
            \ ['UNDOtree', 'UndotreeToggle'],
            \ ['NERDTree', 'NERDTreeToggle'],
            \ ['map', 'Denite output:map'],
            \ ['register', 'Denite output:register'],
            \ ['reload .vimrc', 'source ~/.vimrc'],
            \ ['make Session.vim', 'mks!'],
            \ ['toggle-options', 'Denite menu:toggle'],
            \ ['denite neosnippet', 'Denite unite:neosnippet'],
            \ ['denite gista', 'Denite unite:gista'],
            \ ['denite codic', 'Denite unite:codic'],
            \ ['denite radiko', 'Denite unite:radiko'],
            \ ['stop radiko', 'RadikoStop'],
            \ ['denite RN2-musics', 'Denite unite:rn2musics'],
            \ ['skk-kutouten-type-en', 'let g:skk_kutouten_type = "en"'],
            \ ['skk-kutouten-type-jp', 'let g:skk_kutouten_type = "jp"'],
            \ ['PreVim open', 'PreVimOpen'],
            \ ['copy buffer into clipboard', s:copyToClipboardCommand],
            \]
let s:unite_denite_kaomoji_dictionary = [
            \ ["wahhab", "( っ'ヮ'c)"],
            \ ["wahhab", "三( っ'ヮ'c)"],
            \ ["wahhab", "(っ'ヮ')っ"],
            \ ["wahhab", "(((っ'ヮ')っ"],
            \ ["wahhab", "( っ'ヮ'c)❤"],
            \ ["talk", "( っ'ヮ'c)💬"],
            \ ["sing", "( っ'ヮ'c)～♪"],
            \ ["thinking", "( っ˘ヮ˘c).｡oO(…)"],
            \ ["thinking", "( っ˘ヮ˘c)💭"],
            \ ["sleep", "( っ˘ヮ˘c)💤"],
            \ ["sunglasses", "( っ🕶c)"],
            \ ["no smoking", "(っ'ヮ')っ🚭"],
            \ ["", "( 'ω').｡oO(…)"],
            \ ["", "ヾ(⌒(\_•ω•)\_"],
            \ ["", "ヾ(⌒(ﾉ•ω•)ﾉ"],
            \ ["kyun", "\_(⌒(\_*'ω'*)\_"],
            \ ["kyun", "ヾ(⌒(\_*'ω'*)\_"],
            \ ["kyun", "三ヾ(⌒(\_*'ω'*)\_"],
            \ ["kyun", "（*/ω＼*）"],
            \ ["kyun", "(っ´ω`c)♡"],
            \ ["namida", "\.˚‧º·(´ฅωฅ｀)‧º·˚."],
            \ ["namida", "(☍﹏⁰)"],
            \ ["namida", "( ˃﹏˂ഃ )"],
            \ ["hawawa", "｡ﾟ(ﾟ∩´﹏`∩ﾟ)ﾟ｡"],
            \ ["hawawa", "\:;( っ'﹏'c);:"],
            \ ["hawawa", "\:;( っ'ω'c);:"],
            \ ["hawawa", "\:;(∩´﹏`∩);:"],
            \ ["hawawa", "｡+ﾟ(∩´﹏`∩)ﾟ+｡"],
            \ ["dame", "(乂'ω')"],
            \ ["hawawa", "(っ´﹏`c)"],
            \ ["hawawa", "(｡>﹏<｡)"],
            \ ["awawa", "ヾ(∂╹Δ╹)ﾉ”"],
            \ ["firstspring", "(╯•﹏•╰)"],
            \ ["fuee", "ヾ(｡>﹏<)ﾉ\""],
            \ ["fuee", "✧*。ヾ(｡>﹏<｡)ﾉﾞ。*✧"],
            \ ["ja-n", "٩( 'ω' )و"],
            \ ["ja-n", "٩(*'ω'*)و"],
            \ ["ja-n", "＼＼\\٩( 'ω' )و /／／"],
            \ ["crow", "( っ'ω'c)"],
            \ ["crow", "三( っ'ω'c)"],
            \ ["crow", "( っ˘ω˘c)"],
            \ ["poyo", "(｡・﹏・｡)"],
            \ ["mogumogu", "(∩´〰`∩)"],
            \ ["mogumogu", "ŧ‹\"ŧ‹\"(๑´ㅂ`๑)ŧ‹\"ŧ‹\""],
            \ ["pero", "(๑´ڡ`๑)"],
            \ ["juru", "(๑╹﹃╹)"],
            \ ["makimono", "(๑╹◡╹)o[]o"],
            \ ["matomo", "σ(o'v'o)まとも"],
            \ ["pei", "(っ`ω´c)"],
            \ ["chu", "(っ＞ω＜c)"],
            \ ["chu", "°+♡:.(っ>ω<c).:♡+°"],
            \ ["kichigai", "└(՞ةڼ◔)」"],
            \ ["wa-i", "٩꒰｡•◡•｡꒱۶"],
            \ ["wa-i", "ヾ(✿╹◡╹)ﾉ\""],
            \ ["wa-i", "ヾ(๑╹◡╹)ﾉ\""],
            \ ["wa-i", "ヾ(＠⌒ー⌒＠)ノ"],
            \ ["peta", "\_(⌒(\_-ω-)\_"],
            \ ["mikori", "ヾ(⌒(\_๑›◡‹ )\_"],
            \ ["mozomozo", "(๑•﹏•)"],
            \ ["kyafu", "(⋈◍＞◡＜◍)。✧♡"],
            \ ["wafu", "ヾ(✿＞ヮ＜)ノ"],
            \ ["gu", "╭( ･ㅂ･)و ̑̑ ｸﾞｯ !"],
            \ ["yossha", "(´◔౪◔)۶ﾖｯｼｬ!"],
            \ ["yatta", "+。:.ﾟ٩(๑＞◡＜๑)۶:.｡+ﾟ"],
            \ ["shobon", "(っ◞‸◟c)"],
            \ ["shobon", "(๑´╹‸╹`๑)"],
            \ ["nikkori", "( っ'◡'c)"],
            \ ["beer", "Ʊ\"-ʓ"],
            \ ["beer", "🍺"],
            \ ["beer", "🍻"],
            \ ["angry", "💢"],
            \ ["sushi", "🍣"],
            \ ["yes", "🙆"],
            \ ["no", "🙅🏻"],
            \ ["heart", "❤"],
            \ ["camera", "📸"],
            \ ["fire", "🔥"],
            \ ["arm", "💪🏻"],
            \ ["stop", "✋🏻"],
            \ ["kirakira", "✨"],
            \ ["sake", "🍶"],
            \ ["coffee", "☕"]
            \]
command! -nargs=1 ToggleOption set <args>! <bar> set <args>?
let s:unite_denite_toggle_options = [
            \ "paste",
            \ "rule",
            \ "number",
            \ "relativenumber",
            \ "list",
            \ "hlsearch",
            \ "wrap",
            \ "spell",
            \]

function! s:init_denite_hook_source() abort
    if !exists('s:denite_source_menu')
        let s:denite_source_menu = {}
    endif
    let s:denite_source_menu.shortcut = {
                \ 'description' : 'shortcut'
                \}
    function! s:denite_source_menu_shortcut_mapper(value)
        let [word, value] = a:value

        if isdirectory(value)
            return [word, value]
        elseif !empty(glob(value))
            return [word, value]
        elseif value =~ '^\(http\|https\|ftp\).*'
            return [word, 'OpenBrowser' . value]
        else
            return [word, value]
        endif
    endfunction
    let s:denite_source_menu.shortcut.command_candidates =
                \ map(copy(s:unite_denite_shortcut_candidates), 's:denite_source_menu_shortcut_mapper(v:val)')

    let s:denite_source_menu.toggle = {
                \ 'description' : 'toggle menus',
                \}
    let s:denite_source_menu.toggle.command_candidates =
                \ map(copy(s:unite_denite_toggle_options), '[v:val, "ToggleOption " . v:val]')

    let s:denite_source_menu.kaomoji = {
                \ 'description' : 'kaomoji dictionary',
                \}
    function! s:denite_source_menu_kaomoji_mapper(value)
        let [word, value] = a:value

        if !empty(word)
            let _ = "[" . word . "] "
        else
            let _ = "[no pronounciation] "
        endif

        return [_ . value, "call append(line('.'), \"" . escape(value, "/\"'") . "\")"]
    endfunction
    let s:denite_source_menu.kaomoji.command_candidates =
                \ map(copy(s:unite_denite_kaomoji_dictionary), 's:denite_source_menu_kaomoji_mapper(v:val)')

    call denite#custom#var('menu', 'menus', s:denite_source_menu)

    call denite#custom#alias('source', 'file_rec/git', 'file_rec')
    call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])

    " custom key mappings
    call denite#custom#map('insert', '<Esc>', '<denite:enter_mode:normal>')

    call denite#custom#map('normal', 'sh', '<denite:wincmd:h>')
    call denite#custom#map('normal', 'sj', '<denite:wincmd:j>')
    call denite#custom#map('normal', 'sk', '<denite:wincmd:k>')
    call denite#custom#map('normal', 'sl', '<denite:wincmd:l>')
    call denite#custom#map('normal', 'sw', '<denite:wincmd:w>')
    call denite#custom#map('normal', 'sW', '<denite:wincmd:W>')
    call denite#custom#map('normal', 'st', '<denite:wincmd:t>')
    call denite#custom#map('normal', 'sb', '<denite:wincmd:b>')
    call denite#custom#map('normal', 'sp', '<denite:wincmd:p>')

    call denite#custom#option('default', 'prompt', '❯')
endfunction

function! s:init_denite_hook_add() abort
    nnoremap [denite] <Nop>
    if has('nvim')
        nmap ,u [denite]
    else
        nmap ,uu [denite]
    endif
    " buffer
    nnoremap <silent> [denite]b   :<C-u>Denite buffer<CR>
    " commands
    nnoremap <silent> [denite]c   :<C-u>Denite command<CR>
    " commands history
    nnoremap <silent> [denite]ch  :<C-u>Denite command_history<CR>
    " file
    nnoremap <silent> [denite]f   :<C-u>Denite file_rec<CR>
    " resume
    nnoremap <silent> [denite]r   :<C-u>Denite -resume<CR>
    " register
    nnoremap <silent> [denite]rg  :<C-u>Denite -buffer-name=register register<CR>
    " recently files
    nnoremap <silent> [denite]m   :<C-u>Denite file_mru<CR>
    " menu
    nnoremap <silent> [denite]ms  :<C-u>Denite menu:shortcut -mode=normal<CR>
    nnoremap <silent> [denite]mk  :<C-u>Denite menu:kaomoji<CR>
    " outline (built in source)
    nnoremap <silent> [denite]o   :<C-u>Denite outline<CR>
    " line search
    nnoremap <silent> [denite]/   :<C-u>Denite -buffer-name=search -auto-resize line<CR>
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
    let g:unite_source_menu_menus.shortcut.candidates = s:unite_denite_shortcut_candidates
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

    let g:unite_source_menu_menus.toggle = {
                \ 'description' : 'toggle menus',
                \}
    let g:unite_source_menu_menus.toggle.command_candidates = {}
    for opt in s:unite_denite_toggle_options
        let g:unite_source_menu_menus.toggle.command_candidates[opt] = "ToggleOption " . opt
    endfor

    let g:unite_source_menu_menus.kaomoji = {
                \ 'description' : 'kaomoji dictionary',
                \}
    let g:unite_source_menu_menus.kaomoji.candidates = s:unite_denite_kaomoji_dictionary
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
    if has('nvim')
        nmap ,uu [unite]
    else
        nmap ,u [unite]
    endif
    " buffer
    nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
    " commands
    nnoremap <silent> [unite]c   :<C-u>Unite command<CR>
    " tab
    nnoremap <silent> [unite]t   :<C-u>Unite tab<CR>
    " file
    nnoremap <silent> [unite]f   :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]fr  :<C-u>Unite file_rec<CR>
    " resume
    nnoremap <silent> [unite]r   :<C-u>UniteResume<CR>
    " register
    nnoremap <silent> [unite]rg  :<C-u>Unite -buffer-name=register register<CR>
    " recently files
    nnoremap <silent> [unite]m   :<C-u>Unite file_mru:short<CR>
    nnoremap <silent> [unite]ml  :<C-u>Unite file_mru:long<CR>
    " menu
    nnoremap <silent> [unite]ms  :<C-u>Unite menu:shortcut<CR>
    nnoremap <silent> [unite]msd :<C-u>Unite menu:shortcut -input=[directory]\ <CR>
    nnoremap <silent> [unite]msf :<C-u>Unite menu:shortcut -input=[file]\ <CR>
    nnoremap <silent> [unite]msc :<C-u>Unite menu:shortcut -input=[command]\ <CR>
    nnoremap <silent> [unite]msu :<C-u>Unite menu:shortcut -input=[url]\ <CR>
    nnoremap <silent> [unite]mk  :<C-u>Unite menu:kaomoji -start-insert<CR>
    " source
    nnoremap <silent> [unite]s   :<C-u>Unite source<CR>
    " history
    nnoremap <silent> [unite]hy  :<C-u>Unite history/yank<CR>
    " thinca/vim-unite-history
    nnoremap <silent> [unite]hc  :<C-u>Unite history/command<CR>
    nnoremap <silent> [unite]hs  :<C-u>Unite history/search<CR>
    " Shougo/unite-outline
    nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]oq  :<C-u>Unite -no-quit -buffer-name=outline outline<CR>
    " tsukkee/unite-help
    nnoremap <silent> [unite]he  :<C-u>Unite -start-insert help<CR>
    " rinx/radiko
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

    " toggle skk-kutouten-type
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
    let g:eskk#show_annotation = 0
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
    let g:eskk#start_completion_length = 4
    let g:eskk#register_completed_word = 1
    let g:eskk#use_color_cursor = 0
    " Maybe conflict with arpeggio.vim
    " let g:eskk#keep_state = 1
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
                \ 'elm' : {
                \   'command' : 'elm make',
                \   'exec' : '%c %o',
                \   'runner' : 'vimproc',
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

    function! s:init_quickrun_haskell_stack_hook() abort
        if len(findfile('stack.yaml', '.;', -1))
            let b:quickrun_config = {
                        \ 'command' : 'stack',
                        \ 'exec' : ['%c run'],
                        \}
        endif
    endfunction

    augroup vimrc-init_quickrun_haskell_stack_hook
        autocmd!
        autocmd FileType haskell call <SID>init_quickrun_haskell_stack_hook()
    augroup END

    function! s:init_quickrun_rust_cargo_hook() abort
        if len(findfile('Cargo.toml', '.;', -1))
            let b:quickrun_config = {
                        \ 'command' : 'cargo',
                        \ 'exec' : ['%c run'],
                        \}
        endif
    endfunction

    augroup vimrc-init_quickrun_rust_cargo_hook
        autocmd!
        autocmd FileType rust call <SID>init_quickrun_rust_cargo_hook()
    augroup END
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
    let g:watchdogs_check_BufWritePost_enable_on_wq = 0
    let g:watchdogs_check_CursorHold_enable = 0
    let g:watchdogs_check_CursorHold_enables = {
                \}
endfunction

function! s:init_lexima_hook_post_source() abort
    let g:lexima_no_default_rules = 1
    call lexima#set_default_rules()
    let g:lexima_map_escape = '<Esc>'

    let g:lexima_enable_basic_rules = 1
    let g:lexima_enable_newline_rules = 1
    let g:lexima_enable_space_rules = 1
    let g:lexima_enable_endwise_rules = 1

    " TeX
    call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': ['tex','latex','plaintex']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*%\s.*\%#', 'input': '<CR>% ', 'filetype': ['tex','latex','plaintex']})

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

    " markdown
    call lexima#add_rule({'char': '**', 'input_after': '**', 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<BS>', 'at': '\*\%#\*', 'delete': 1, 'filetype': ['markdown']})
    call lexima#add_rule({'char': '__', 'input_after': '__', 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<BS>', 'at': '_\%#_', 'delete': 1, 'filetype': ['markdown']})
    call lexima#add_rule({'char': '~~', 'input_after': '~~', 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<BS>', 'at': '\~\%#\~', 'delete': 1, 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*\*\s.*\%#', 'input': '<CR>* ', 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*+\s.*\%#', 'input': '<CR>+ ', 'filetype': ['markdown']})
    call lexima#add_rule({'char': '<CR>', 'at': '^\s*-\s.*\%#', 'input': '<CR>- ', 'filetype': ['markdown']})
endfunction

function! s:init_gitgutter_hook_add() abort
    let g:gitgutter_max_signs = 10000
    let g:gitgutter_map_keys = 0
    let g:gitgutter_sign_added = '+'
    let g:gitgutter_sign_modified = '*'
    let g:gitgutter_sign_removed = '-'
    let g:gitgutter_sign_modified_removed = '~'
endfunction

function! s:init_undotree_hook_add() abort
    nnoremap <F5> :<C-u>UndotreeToggle<CR>
endfunction

function! s:init_undotree_hook_source() abort
    let g:undotree_WindowLayout = 1
    let g:undotree_SplitWidth = 50
    let g:undotree_DiffpanelHeight = 10
    let g:undotree_DiffAutoOpen = 1
    let g:undotree_SetFocusWhenToggle = 0
    let g:undotree_HighlightChangedText = 1
endfunction

function! s:init_nerdtree_hook_add() abort
    nnoremap <F6> :<C-u>NERDTreeToggle<CR>
endfunction

function! s:init_nerdtree_hook_source() abort
    augroup vimrc-nerdtree
        autocmd!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
        autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&filetype')) == 'nerdtree' | q | endif
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
    map *   <Plug>(asterisk-*)<Plug>(anzu-update-search-status-with-echo)
    map #   <Plug>(asterisk-#)<Plug>(anzu-update-search-status-with-echo)
    map g*  <Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
    map g#  <Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)
    map z*  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
    map gz* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
    map z#  <Plug>(asterisk-z#<Plug>(anzu-update-search-status-with-echo))
    map gz# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)
endfunction

function! s:init_incsearch_hook_add() abort
    function! s:init_incsearch_hook_add_autocmd() abort
        " except for
        let _ = [
                    \ 'markdown',
                    \ 'latex',
                    \ 'tex',
                    \ 'plaintex',
                    \ ]
        if index(_, &ft) < 0
            map <buffer>/  <Plug>(incsearch-forward)
            map <buffer>?  <Plug>(incsearch-backward)
            map <buffer>g/ <plug>(incsearch-stay)
        endif
    endfunction
    augroup vimrc-incsearch
        autocmd!
        autocmd FileType * call s:init_incsearch_hook_add_autocmd()
    augroup END
endfunction

function! s:init_auto_programming_hook_add() abort
    set completefunc=autoprogramming#complete
endfunction

function! s:init_anzu_hook_add() abort
    nmap n <Plug>(anzu-n)zz
    nmap N <Plug>(anzu-N)zz
    augroup vimrc-anzu
        autocmd!
        autocmd CursorHold,CursorHoldI,WinLeave,Tableave * call anzu#clear_search_status()
    augroup END
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

    nmap f <Plug>(clever-f-f)
    nmap F <Plug>(clever-f-F)
    nmap t <Plug>(clever-f-t)
    nmap T <Plug>(clever-f-T)
    nmap <Space> <Plug>(clever-f-reset)
endfunction

function! s:init_jplus_hook_add() abort
    nmap J <Plug>(jplus)
    vmap J <Plug>(jplus)

    nmap <Leader>J <Plug>(jplus-getchar)
    vmap <Leader>J <Plug>(jplus-getchar)
    nmap <Leader><Space>J <Plug>(jplus-getchar-with-space)
    vmap <Leader><Space>J <Plug>(jplus-getchar-with-space)

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
                \ '__EMPTY__' : {
                \   'delimiter_format' : '%d',
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

function! s:init_easy_align_hook_add() abort
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endfunction

" operator

function! s:init_operator_replace_hook_add() abort
    Arpeggio map or <Plug>(operator-replace)
endfunction

function! s:init_caw_comment_hook_add() abort
    let g:caw_no_default_keymappings = 1
    Arpeggio map oc <Plug>(caw:hatpos:toggle:operator)
    Arpeggio map od <Plug>(caw:hatpos:uncomment:operator)
    Arpeggio map oe <Plug>(caw:zeropos:toggle:operator)
endfunction

function! s:init_operator_surround_hook_add() abort
    map Sa <Plug>(operator-surround-append)
    map Sd <Plug>(operator-surround-delete)
    map Sr <Plug>(operator-surround-replace)
endfunction


" textobj
function! s:init_textobj_jabraces_hook_add() abort
    let g:textobj_jabraces_no_default_key_mappings = 1

    " the mappings are defined in multitextobj group A
endfunction

function! s:init_textobj_between_hook_add() abort
    let g:textobj_between_no_default_key_mappings = 1

    omap ac <Plug>(textobj-between-a)
    omap ic <Plug>(textobj-between-i)
    vmap ac <Plug>(textobj-between-a)
    vmap ic <Plug>(textobj-between-i)
endfunction

function! s:init_textobj_multiblock_hook_add() abort
    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    vmap ab <Plug>(textobj-multiblock-a)
    vmap ib <Plug>(textobj-multiblock-i)

    function! s:init_textobj_multiblock_hook_add_tex() abort
        let b:textobj_multiblock_blocks = [
                    \ ['\$', '\$', 1],
                    \ ['\$\$', '\$\$', 1],
                    \ ]
    endfunction
    function! s:init_textobj_multiblock_hook_add_markdown() abort
        let b:textobj_multiblock_blocks = [
                    \ ['`', '`', 1],
                    \ ['```', '```'],
                    \ ]
    endfunction
    function! s:init_textobj_multiblock_hook_add_ruby() abort
        let b:textobj_multiblock_blocks = [
                    \ ['/', '/', 1],
                    \ ]
    endfunction

    augroup vimrc-init_multiblock_hook_add
        autocmd!
        autocmd FileType tex,latex,plaintex call <SID>init_textobj_multiblock_hook_add_tex()
        autocmd FileType markdown call <SID>init_textobj_multiblock_hook_add_markdown()
        autocmd FileType ruby call <SID>init_textobj_multiblock_hook_add_ruby()
    augroup END
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

    " jabraces
    let g:textobj_multitextobj_textobjects_group_i = {}
    let g:textobj_multitextobj_textobjects_group_i.A = [
                \   '<Plug>(textobj-jabraces-sumi-kakko-i)',
                \   '<Plug>(textobj-jabraces-parens-i)',
                \   '<Plug>(textobj-jabraces-kakko-i)',
                \   '<Plug>(textobj-jabraces-double-kakko-i)',
                \ ]
    let g:textobj_multitextobj_textobjects_group_a = {}
    let g:textobj_multitextobj_textobjects_group_a.A = [
                \   '<Plug>(textobj-jabraces-sumi-kakko-a)',
                \   '<Plug>(textobj-jabraces-parens-a)',
                \   '<Plug>(textobj-jabraces-kakko-a)',
                \   '<Plug>(textobj-jabraces-double-kakko-a)',
                \ ]
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
                \ 'yahoojp': 'http://search.yahoo.co.jp/search?p={query}',
                \},
                \)

    nmap ,op <Plug>(openbrowser-smart-search)
    vmap ,op <Plug>(openbrowser-smart-search)

    nnoremap <silent> ,og :<C-u>OpenBrowserSearch -google <C-r><C-w><CR>
    nnoremap <silent> ,oy :<C-u>OpenBrowserSearch -yahoojp <C-r><C-w><CR>
    nnoremap <silent> ,ow :<C-u>OpenBrowserSearch -weblio <C-r><C-w><CR>
    nnoremap <silent> ,oa :<C-u>OpenBrowserSearch -alc <C-r><C-w><CR>

    call altercmd#define('google', 'OpenBrowserSearch -google')
    call altercmd#define('yahoo', 'OpenBrowserSearch -yahoojp')
    call altercmd#define('weblio', 'OpenBrowserSearch -weblio')
    call altercmd#define('alc', 'OpenBrowserSearch -alc')
endfunction

function! s:init_gfm_syntax_hook_source() abort
    let g:gfm_syntax_emoji_conceal = 1
endfunction

function! s:init_github_complete_hook_source() abort
    let g:github_complete_enable_neocomplete = 1
    let g:github_complete_enable_omni_completion = 0
    imap <C-x>e <Plug>(github-complete-manual-completion)
endfunction

function! s:init_haskell_vim_hook_source() abort
    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

    let g:haskell_indent_if = 4
    let g:haskell_indent_case = 4
    let g:haskell_indent_let = 4
    let g:haskell_indent_before_where = 0
    let g:haskell_indent_after_bare_where = 4
    let g:haskell_indent_do = 4
    let g:haskell_indent_in = 1
    let g:haskell_indent_guard = 4
    let g:haskell_indent_case_alternative = 4
    let g:cabal_indent_section = 2
endfunction

function! s:init_ref_hoogle_hook_add() abort
    call altercmd#define('hoogle', 'Ref hoogle')
    nnoremap <silent> [ref]hg :<C-u>Ref hoogle <C-r><C-w><CR>
endfunction

function! s:init_yesod_hook_source() abort
    let g:yesod_disable_maps = 1
endfunction

function! s:init_elm_hook_source() abort
    let g:elm_jump_to_error = 0
    let g:elm_setup_keybindings = 0
    let g:elm_make_show_warnings = 1
    let g:elm_detailed_complete = 1
    let g:elm_format_fail_silently = 1
    nmap <Leader>d <Plug>(elm-show-docs)
endfunction


function! s:init_go_hook_source() abort
    augroup vimrc-golang
        autocmd!
        autocmd FileType go setlocal noexpandtab
        autocmd FileType go setlocal sw=4
        autocmd FileType go setlocal ts=4
        autocmd FileType go compiler go
    augroup END
endfunction

function! s:init_racer_hook_source() abort
    set hidden
    let g:racer_cmd = expand('~/.cargo/bin/racer')
    let g:racer_experimental_completer = 1
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

function! s:init_translategoogle_hook_add() abort
    let g:translategoogle_languages = ["ja", "en"]
    let g:translategoogle_default_sl = "en"
    let g:translategoogle_default_tl = "ja"
    let g:translategoogle_default_ie = "UTF-8"
    let g:translategoogle_default_oe = "UTF-8"
    let g:translategoogle_default_opener_before = "8split"
    let g:translategoogle_default_opener_after = "rightbelow vsplit"
    let g:translategoogle_default_opener_retrans = "rightbelow vsplit"
    let g:translategoogle_enable_retranslate = 0
    let g:translategoogle_mapping_close = "q"
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
    let g:radiko#is_loaded = 0
    let g:radiko#cache_dir = expand("~/.cache/radiko-vim")

    function! s:radiko_echo_rn2_musics()
        let playing = radiko#get_playing_rn2_music()
        let nextone = radiko#get_next_rn2_music()
        return '[Now playing]: ' . playing[0] . ' - ' . playing[1]
                    \ . ' [Next]: ' . nextone[0] . ' - ' . nextone[1]
    endfunction
    command! RadikoRN2Musics echo <SID>radiko_echo_rn2_musics()
endfunction

function! s:init_radiko_hook_source() abort
    let g:radiko#is_loaded = 1
endfunction

function! s:init_yj_proofreading_hook_add() abort
    if exists('g:vimrc_private["yahoo_proofreader_apikey"]')
        let g:yj_proofreading#yahoo_apikey = g:vimrc_private['yahoo_proofreader_apikey']
    endif
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

function! s:init_hybrid_hook_add() abort
    set background=dark
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

    augroup vimrc-colorscheme-hybrid 
        autocmd!
        autocmd VimEnter * nested colorscheme hybrid
    augroup END

    highlight Normal ctermbg=none
endfunction


" --- plugin loading with dein.vim
if has('nvim')
    let s:dein_dir = '~/.config/nvim/dein'
else
    let s:dein_dir = '~/.vim/dein'
endif

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(expand(s:dein_repo_dir))
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

if v:version >= 800 || has('nvim') && dein#load_state(s:dein_dir)
    if has('vim_starting')
        execute 'set runtimepath+=' . s:dein_repo_dir
    endif
    call dein#begin(expand(s:dein_dir . '/'))

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

    if has('nvim')
        call dein#add('Shougo/deoplete.nvim', {
                    \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_deoplete_hook_add()',
                    \ })
        call dein#config('deoplete.nvim', {
                    \ 'lazy': 1,
                    \ 'on_i': 1,
                    \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_deoplete_hook_source()',
                    \})
    else
        call dein#add('Shougo/neocomplete.vim', {
                    \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_neocomplete_hook_add()',
                    \ })
        call dein#config('neocomplete.vim', {
                    \ 'lazy': 1,
                    \ 'on_i': 1,
                    \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_neocomplete_hook_source()',
                    \})
    endif

    " neocomplete/deoplete sources 
    call dein#add('ujihisa/neco-look')
    call dein#config('neco-look', {
                \ 'lazy' : 1,
                \ 'on_i' : 1,
                \})
    call dein#add('Shougo/neco-syntax')
    call dein#config('neco-syntax', {
                \ 'lazy' : 1,
                \ 'on_i' : 1,
                \})
    call dein#add('Shougo/neco-vim')
    call dein#config('neco-vim', {
                \ 'lazy' : 1,
                \ 'on_ft' : [
                \     'vim',
                \ ],
                \})
    call dein#add('eagletmt/neco-ghc')
    call dein#config('neco-ghc', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'haskell',
                \ ],
                \})

    " deoplete sources (only for neovim)
    if has('nvim')
        call dein#add('rinx/deoplete-auto-programming')
        call dein#config('deoplete-auto-programming', {
                    \ 'lazy': 1,
                    \ 'on_i': 1,
                    \})
        call dein#add('fishbullet/deoplete-ruby')
        call dein#config('deoplete-ruby', {
                    \ 'lazy': 1,
                    \ 'on_ft': [
                    \   'ruby',
                    \ ],
                    \})
        call dein#add('sebastianmarkow/deoplete-rust')
        call dein#config('deoplete-rust', {
                    \ 'lazy': 1,
                    \ 'on_ft': [
                    \   'rust',
                    \ ],
                    \})
        call dein#add('pbogut/deoplete-elm')
        call dein#config('deoplete-elm', {
                    \ 'lazy': 1,
                    \ 'on_ft': [
                    \   'elm',
                    \ ],
                    \})
        call dein#add('zchee/deoplete-go')
        call dein#config('deoplete-go', {
                    \ 'lazy': 1,
                    \ 'on_ft': [
                    \   'go',
                    \ ],
                    \})
        call dein#add('mitsuse/autocomplete-swift')
        call dein#config('autocomplete-swift', {
                    \ 'lazy': 1,
                    \ 'on_ft': [
                    \   'swift',
                    \ ],
                    \ 'on_path': [
                    \   '.*.swift$',
                    \ ],
                    \})
        if has('mac')
            call dein#add('thalesmello/webcomplete.vim')
            call dein#config('webcomplete.vim', {
                        \ 'lazy': 1,
                        \ 'on_i': 1,
                        \})
        endif
    endif

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

    call dein#add('cocopon/vaffle.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_vaffle_hook_add()',
                \})
    call dein#config('vaffle.vim', {
                \ 'lazy': 1,
                \ 'on_cmd' : [
                \   'Vaffle',
                \ ],
                \})

    call dein#add('kana/vim-submode', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_submode_hook_add()',
                \})
    call dein#add('kana/vim-arpeggio', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_arpeggio_hook_add()',
                \})
    call dein#add('kana/vim-altercmd')

    call dein#add('Shougo/denite.nvim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_denite_hook_add()',
                \})
    call dein#config('denite.nvim', {
                \ 'lazy': 1,
                \ 'on_cmd' : [
                \   'Denite',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_denite_hook_source()',
                \})

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
                \ 'on_func': [
                \   'unite',
                \ ],
                \})
    call dein#add('Shougo/neomru.vim')
    call dein#config('neomru.vim', {
                \ 'lazy': 1,
                \ 'on_source': [
                \   'denite.nvim',
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
    call dein#add('pasela/unite-webcolorname')
    call dein#config('unite-webcolorname', {
                \ 'lazy': 1,
                \ 'on_source': [
                \   'unite.vim',
                \ ],
                \})

    call dein#add('itchyny/lightline.vim')

    if has('nvim')
        let s:enable_eskk = 1
    else
        let s:enable_eskk = 0
    endif
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
    call dein#config('shabadou.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'QuickRun',
                \ ],
                \ 'on_map': [
                \   '<Plug>(quickrun',
                \ ],
                \})
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

    call dein#add('thinca/vim-themis', {'lazy': 1})

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

    call dein#add('mbbill/undotree', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_undotree_hook_add()',
                \})
    call dein#add('mbbill/undotree', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'UndotreeToggle',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_undotree_hook_source()',
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
    call dein#config('vim-migemo', {
                \ 'lazy': 1,
                \ 'on_map': [
                \   '<Plug>(migemo-',
                \ ],
                \ 'on_func': [
                \   'migemo',
                \ ],
                \})

    if !has('nvim')
        call dein#add('haya14busa/vim-auto-programming', {
                    \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_auto_programming_hook_add()',
                    \})
        call dein#config('vim-auto-programming', {
                    \ 'lazy': 1,
                    \ 'on_i': 1,
                    \})
    endif

    call dein#add('osyo-manga/vim-anzu', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_anzu_hook_add()',
                \})
    call dein#config('vim-anzu', {
                \ 'lazy': 1,
                \ 'on_map': [
                \   '<Plug>(anzu-',
                \ ],
                \ 'on_func': [
                \   'anzu',
                \ ],
                \ 'on_event': [
                \   'TabLeave',
                \ ],
                \})
    call dein#add('osyo-manga/vim-over')
    call dein#config('vim-over', {
                \ 'lazy': 1,
                \ 'on_func': [
                \   'over',
                \ ],
                \ 'on_cmd': [
                \   'OverCommandLine',
                \ ],
                \})

    call dein#add('rhysd/clever-f.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_cleverf_hook_add()',
                \})
    call dein#config('clever-f.vim', {
                \ 'lazy': 1,
                \ 'on_i': 1,
                \})
    call dein#add('osyo-manga/vim-jplus', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_jplus_hook_add()',
                \})
    call dein#config('vim-jplus', {
                \ 'lazy': 1,
                \ 'on_map': [
                \   '<Plug>(jplus)',
                \   '<Plug>(jplus-',
                \ ],
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

    call dein#add('Konfekt/FastFold')

    call dein#add('junegunn/vim-easy-align', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_easy_align_hook_add()',
                \})
    call dein#config('vim-easy-align', {
                \ 'lazy': 1,
                \ 'on_map': [
                \   '<Plug>(EasyAlign)',
                \ ],
                \ 'on_cmd': [
                \   'EasyAlign',
                \ ],
                \})

    " operator reference
    " <or>: replace
    " <oc>: comment toggle
    " <od>: uncomment
    " <oe>: comment toggle (zeropos)
    " Sa: surround-append
    " Sd: surround-delete
    " Sr: surround-replace

    call dein#add('kana/vim-operator-user')
    call dein#add('kana/vim-operator-replace', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_operator_replace_hook_add()',
                \})
    call dein#add('tyru/caw.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_caw_comment_hook_add()',
                \})
    call dein#add('rhysd/vim-operator-surround', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_operator_surround_hook_add()',
                \})

    " textobj reference
    " ai, ii: indent
    " af, if: function
    " ae, ie: entire
    " al, il: line
    " ajb, ijb: ja-braces
    " ac, ic: between
    " au, iu: url
    " ab, ib: multiblock
    " amt, imt: multitextobj (url, multiblock, function, entire)
    " av, iv: variable segment
    " ar, ir: ruby

    call dein#add('kana/vim-textobj-user')
    call dein#add('kana/vim-textobj-indent')
    call dein#add('kana/vim-textobj-function')
    call dein#add('kana/vim-textobj-entire')
    call dein#add('kana/vim-textobj-line')
    call dein#add('kana/vim-textobj-jabraces', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_jabraces_hook_add()',
                \})
    call dein#add('thinca/vim-textobj-between', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_between_hook_add()',
                \})
    call dein#add('mattn/vim-textobj-url')
    call dein#add('osyo-manga/vim-textobj-multiblock', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_multiblock_hook_add()',
                \})
    call dein#add('osyo-manga/vim-textobj-multitextobj', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_textobj_multitextobj_hook_add()',
                \})
    call dein#add('Julian/vim-textobj-variable-segment')
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

    call dein#add('rhysd/vim-gfm-syntax')
    call dein#config('vim-gfm-syntax', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'markdown',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_gfm_syntax_hook_source()',
                \})

    call dein#add('rhysd/github-complete.vim')
    call dein#config('github-complete.vim', {
                \ 'lazy': 1,
                \ 'on_i': 1,
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_github_complete_hook_source()',
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
    call dein#add('neovimhaskell/haskell-vim')
    call dein#config('haskell-vim', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'haskell',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_haskell_vim_hook_source()',
                \})
    call dein#add('ujihisa/ref-hoogle', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_ref_hoogle_hook_add()',
                \})
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
    call dein#add('alx741/yesod.vim')
    call dein#config('yesod.vim', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'haskell',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_yesod_hook_source()',
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
    call dein#add('ElmCast/elm-vim')
    call dein#config('elm-vim', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'elm',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_elm_hook_source()',
                \})

    call dein#add('fatih/vim-go')
    call dein#config('vim-go', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'go',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_go_hook_source()',
                \})

    call dein#add('rust-lang/rust.vim')
    call dein#config('rust.vim', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'rust',
                \ ],
                \})
    call dein#add('racer-rust/vim-racer')
    call dein#config('vim-racer', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'rust',
                \ ],
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_racer_hook_source()',
                \})

    call dein#add('keith/swift.vim')
    call dein#config('swift.vim', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'swift',
                \ ],
                \ 'on_path': [
                \   '.*.swift$',
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

    call dein#add('stephpy/vim-yaml')
    call dein#config('vim-yaml', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'yaml',
                \ ],
                \})

    call dein#add('tmux-plugins/vim-tmux')
    call dein#config('vim-tmux', {
                \ 'lazy': 1,
                \ 'on_ft': [
                \   'tmux',
                \ ],
                \ 'on_path': [
                \   'tmux.conf',
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

    call dein#add('daisuzu/translategoogle.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_translategoogle_hook_add()',
                \})
    call dein#config('translategoogle.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'TranslateGoogle',
                \   'TranslateGoogleCmd',
                \   'TranslateGoogleCmdReverse',
                \ ],
                \})

    call dein#add('mattn/webapi-vim')

    call dein#add('lambdalisue/gina.vim')
    call dein#config('gina.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'Gina',
                \ ],
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
                \ 'on_func': [
                \   'codic',
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
                \ 'hook_source': 'call ' . s:SID_PREFIX() . 'init_radiko_hook_source()',
                \})

    call dein#add('rinx/yj-proofreading.vim', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_yj_proofreading_hook_add()',
                \})
    call dein#config('yj-proofreading.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'YahooProofReader',
                \ ],
                \ 'on_func': [
                \   'yjproofreading',
                \ ],
                \})

    " call dein#add('tomasr/molokai')
    " call dein#add('sickill/vim-monokai')
    " call dein#add('jpo/vim-railscasts-theme')
    call dein#add('w0ng/vim-hybrid', {
                \ 'hook_add': 'call ' . s:SID_PREFIX() . 'init_hybrid_hook_add()',
                \})

    call dein#add('vim-jp/vital.vim')
    call dein#config('vital.vim', {
                \ 'lazy': 1,
                \ 'on_cmd': [
                \   'Vitalize',
                \ ],
                \ 'on_func': [
                \   'vital',
                \ ],
                \})

    call dein#end()
    call dein#save_state()

    if has('vim_starting') && dein#check_install()
        call dein#install()
        if has('nvim')
            call dein#remote_plugins()
        endif
    endif
else
    echo "If you want to use plugins, you should use VIM 8.0, newer one, or NVIM."
endif

set viminfo='1000,<100,f1,h,s100
set history=300

set bs=indent,eol,start

set ruler
set number
set cursorline
" set cursorcolumn
set cmdheight=2
set wildmenu
set wildchar=<Tab>
set wildmode=longest:full,full

set imdisable

set incsearch
set ignorecase
set smartcase

filetype plugin indent on
set autoindent
set smartindent
set breakindent

" unsaved buffer warning
set confirm

if has('nvim')
    set clipboard+=unnamed,unnamedplus
else
    set clipboard+=unnamed,autoselect
endif

set mouse=a
if !has('nvim')
    set ttymouse=xterm2
endif

set foldmethod=marker

set virtualedit=block

set expandtab
set smarttab
set tabstop=8
set shiftwidth=4
set softtabstop=4

if &term=="xterm"
    set t_Co=256
    set t_Sb=[4%dm
    set t_Sf=[3%dm
endif

syntax on
set hlsearch

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set visualbell
set lazyredraw
set ttyfast

set sessionoptions+=tabpages
set sessionoptions-=options

set showmatch
set matchtime=3

if v:version >= 703 && !has('nvim')
    set cryptmethod=blowfish
    set conceallevel=0
endif

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

set list
set listchars=eol:¬,tab:▸\ ,extends:>,precedes:<,trail:-

set noautochdir
set autoread
set noautowrite

set noexrc
set nosecure

set timeout
set timeoutlen=1000
set ttimeoutlen=200

syntax enable

" A function to convert csv to markdown table
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

" A function to convert csv to tex table
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
function! s:make_japanese_input_window()
    let _ = ''
    if has('mac')
        let _ = 'w !pbcopy'
        augroup vimrc-makeJapaneseInputWindow
            autocmd!
            autocmd InsertLeave,FileType input_via_skk
                        \ call <SID>cp_from_japanese_input_window('w !pbcopy')
        augroup END
    elseif has('unix')
        let _ = 'w !xsel --clipboard --input'
        augroup vimrc-makeJapaneseInputWindow
            autocmd!
            autocmd InsertLeave,FileType input_via_skk
                        \ call <SID>cp_from_japanese_input_window('w !xsel --clipboard --input')
        augroup END
    endif
    let newbufname = 'input_via_skk'
    silent! execute 'new' newbufname
    silent! execute 'setlocal' ('filetype=' . newbufname)

    silent! execute 'nnoremap <buffer> <CR> :' . _ . '<CR>dd'
    silent! nnoremap <buffer> q :<C-u>q!<CR>
endfunction

function! s:cp_from_japanese_input_window(cpcmd)
    silent! execute a:cpcmd
    silent! execute "call setline('.', '')"
endfunction

command! MakeJapaneseInputWindow call s:make_japanese_input_window()


function! s:init_rails_routes_quickfix_hook() abort
    let g:rails_routes_quickfix_cmd = "bin/rake routes"
    function! s:init_rails_routes_quickfix() abort
        cexpr system(g:rails_routes_quickfix_cmd)
        copen
    endfunction

    command! RailsRoutesOnQuickfix call <SID>init_rails_routes_quickfix()
endfunction

augroup vimrc-init_rails_routes_quickfix_hook
    autocmd!
    autocmd FileType ruby call <SID>init_rails_routes_quickfix_hook()
augroup END


" completion function for fixed candidate list
" example:
" let testlist = [
"             \ ['immobile', 'immobile: 動かせない'],
"             \ ['immodest', 'immodest: 慎みのない'],
"             \ ['immoderation', 'immoderation: 過度'],
"             \ ['immodulated', 'immodulated: 節度のない'],
"             \]
" inoremap <silent> <C-x>a <C-r>=<SID>anything_complete(testlist, '[testlist]')<CR>
function! s:anything_complete(list, menu)
    let line = getline('.')
    let start = match(line, '\k\+$')
    let candlist = map(copy(a:list), '{
                \ "word": v:val[0],
                \ "abbr": v:val[1],
                \ "menu": a:menu
                \}')
    let cand = s:anything_complete_candidates(candlist, line[start :])
    call complete(start +1, cand)
    return ''
endfunction
function! s:anything_complete_candidates(list, arglead)
    return filter(copy(a:list), 'stridx(v:val.word, a:arglead) == 0')
endfunction

" https://gist.github.com/sgur/4e1cc8e93798b8fe9621
inoremap <silent> <C-x>c <C-R>=<SID>codic_complete()<CR>
function! s:codic_complete()
    let line = getline('.')
    let start = match(line, '\k\+$')
    let cand = s:codic_candidates(line[start :])
    call complete(start +1, cand)
    return ''
endfunction
function! s:codic_candidates(arglead)
    let cand = codic#search(a:arglead, 30)
    " error
    if type(cand) == type(0)
        return []
    endif
    " english -> english terms
    if a:arglead =~# '^\w\+$'
        return map(cand, '{"word": v:val["label"], "menu": join(map(copy(v:val["values"]), "v:val.word"), ",")}')
    endif
    " japanese -> english terms
    return s:reverse_candidates(cand)
endfunction
function! s:reverse_candidates(cand)
    let _ = []
    for c in a:cand
        for v in c.values
            call add(_, {"word": v.word, "menu": !empty(v.desc) ? v.desc : c.label })
        endfor
    endfor
    return _
endfunction

" Google suggestions
" based on https://github.com/mattn/googlesuggest-complete-vim
inoremap <silent> <C-x>g <C-R>=<SID>googlesuggestion_complete()<CR>
function! s:googlesuggestion_complete()
    let line = getline('.')
    let start = match(line, '\k\+$')
    let cand = s:googlesuggestion_candidates(line[start :])
    call complete(start +1, cand)
    return ''
endfunction
function! s:googlesuggestion_candidates(arglead)
    let ret = []
    let res = webapi#http#get('http://suggestqueries.google.com/complete/search', {
                \ "client" : "youtube", 
                \ "q" : a:arglead,
                \ "hjson" : "t",
                \ "hl" : "ja",
                \ "ie" : "UTF8",
                \ "oe" : "UTF8",
                \})
    let arr = webapi#json#decode(res.content)
    for m in arr[1]
        call add(ret, m[0])
    endfor
    return ret
endfunction

let s:unite_source_googlesuggestion = {
            \ 'name': 'googlesuggestion',
            \ 'action_table' : {
            \   'google_search' : {
            \     'description' : 'google by this word.',
            \   },
            \ },
            \ 'default_action' : 'google_search',
            \}

function! s:unite_source_googlesuggestion.action_table.google_search.func(candidate)
    call dein#source('open-browser.vim')
    call openbrowser#search(a:candidate.word, 'google')
endfunction

function! s:unite_source_googlesuggestion.change_candidates(args, context)
    let word = matchstr(a:context.input, '^\(\S\|\s\)\+')

    if word == '' 
        return []
    endif

    let cand = s:googlesuggestion_candidates(word)
    let cand = extend([word], cand)
    return map(cand, '{
                \ "word": v:val,
                \ }')
endfunction

augroup vimrc-unite-googlesuggestion-define
    autocmd!
    autocmd VimEnter * call unite#define_source(s:unite_source_googlesuggestion)
augroup END

function! s:get_wild_and_tough()
    " http://qiita.com/lVlA/items/0b14dd6dc7e69ed435dc

    call append(line(".") +  0, "  ____      _")
    call append(line(".") +  1, " / ___| ___| |_")
    call append(line(".") +  2, "| |  _ / _ \\ __|")
    call append(line(".") +  3, "| |_| |  __/ |_")
    call append(line(".") +  4, " \\____|\\___|\\__|")
    call append(line(".") +  5, "__        __  _     _")
    call append(line(".") +  6, "\\ \\      / (_) | __| |")
    call append(line(".") +  7, " \\ \\ /\\ / /| | |/ _  |")
    call append(line(".") +  8, "  \\ V  V / | | | (_| |")
    call append(line(".") +  9, "   \\_/\\_/  |_|_|\\__,_|")
    call append(line(".") + 10, "    _              _")
    call append(line(".") + 11, "   / \\   _ __   __| |")
    call append(line(".") + 12, "  / _ \\ | '_ \\ / _  |")
    call append(line(".") + 13, " / ___ \\| | | | (_| |")
    call append(line(".") + 14, "/_/   \\_\\_| |_|\\__,_|")
    call append(line(".") + 15, " _                    _")
    call append(line(".") + 16, "| |_ ___  _   _  __ _| |__")
    call append(line(".") + 17, "| __/ _ \\| | | |/ _  |  _ \\")
    call append(line(".") + 18, "| || (_) | |_| | (_| | | | |")
    call append(line(".") + 19, "\\__\\___/ \\__,_|\\__,  |_| |_|")
    call append(line(".") + 20, "                |___/")
endfunction

command! GetWildAndTough call s:get_wild_and_tough()

" visualize '　'
" http://inari.hatenablog.com/entry/2014/05/05/231307
function! s:zenkaku_space()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction
if has('syntax')
    augroup vimrc-zenkaku_space
        autocmd!
        autocmd ColorScheme * call <SID>zenkaku_space()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call <SID>zenkaku_space()
endif

let g:mapleader = '\'

" reload .vimrc
nnoremap <C-r><C-f> :source ~/.vimrc<CR>

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Disable cursor keys
nnoremap <Left> <Nop>
nnoremap <Down> <Nop>
nnoremap <Up> <Nop>
nnoremap <Right> <Nop>

inoremap <Left> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>

" For TMUX
nnoremap <C-t> <Nop>

" Remap to act as expected
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
vnoremap j gj
vnoremap k gk
onoremap j gj
onoremap k gk

nnoremap gj j
nnoremap gk k
nnoremap g0 0
nnoremap g$ $
vnoremap gj j
vnoremap gk k
onoremap gj j
onoremap gk k

" Use Y as y$
nnoremap Y y$

" Access to system clipboard
nnoremap ,p "+p
nnoremap ,P "+P

" yank (copy) and delete (cut) for system clipboard
nnoremap ,y "+y
nnoremap ,d "+d
vnoremap ,y "+y
vnoremap ,d "+d

" Use history with C-p or C-n on command-mode
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" for tabline
nnoremap [Tab] <Nop>
nmap ,t [Tab]
" for buffer
nnoremap [Buf] <Nop>
nmap ,b [Buf]

for s:n in range(1, 9)
    execute 'nnoremap <silent> [Tab]'. s:n ':<C-u>tabnext'. s:n .'<CR>'
    execute 'nnoremap <silent> [Buf]'. s:n ':<C-u>buffer '. s:n .'<CR>'
endfor

nnoremap <silent> [Tab]c :<C-u>tablast <bar> tabnew<CR>
nnoremap <silent> [Tab]x :<C-u>tabclose<CR>
nnoremap <silent> [Tab]n :<C-u>tabnext<CR>
nnoremap <silent> [Tab]p :<C-u>tabprevious<CR>

" for window
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

" toggle paste mode
nnoremap <silent> <Leader>p :setl paste!<CR>

" toggle relativenumber
nnoremap <silent> <Leader>r :setl relativenumber!<CR>

" toggle spell check
nnoremap <silent> <Leader>s :setl spell!<CR>

" close special windows from another window
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
                \ 'ref-webdict',
                \ 'unite',
                \ 'denite',
                \ 'vaffle',
                \ 'qf',
                \ 'quickrun',
                \ 'undotree',
                \ 'nerdtree',
                \ 'help',
                \ 'input_via_skk',
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

" disable some default mappings
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" sticky shift
" http://vim-jp.org/vim-users-jp/2009/08/09/Hack-54.html
inoremap <expr> ; <SID>sticky_func()
cnoremap <expr> ; <SID>sticky_func()
snoremap <expr> ; <SID>sticky_func()

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

" QuickFix window
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

" Help window
augroup vimrc-forHelpWindow
    autocmd!
    " mappings
    autocmd FileType help nnoremap <buffer> j j
    autocmd FileType help nnoremap <buffer> k k
    autocmd FileType help nnoremap <buffer> 0 0
    autocmd FileType help nnoremap <buffer> $ $
    autocmd FileType help nnoremap <buffer> gj gj
    autocmd FileType help nnoremap <buffer> gk gk
    autocmd FileType help nnoremap <buffer> g0 g0
    autocmd FileType help nnoremap <buffer> g$ g$
    autocmd FileType help nnoremap <buffer><silent>q :<C-u>q<CR>
    " autoclose
    autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'help' | q | endif
augroup END

augroup vimrc-filetype-force-tex
    autocmd!
    autocmd FileType latex,plaintex setlocal filetype=tex
augroup END

set laststatus=2
set showtabline=2

if has('nvim')
    let lightline_colorscheme = 'one'
else
    let lightline_colorscheme = 'default'
endif

let g:lightline = {
            \ 'active': {
            \   'left': [ 
            \             [ 'mode', 'paste', 'spell' ],
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
            \ 'colorscheme' : lightline_colorscheme,
            \ }

function! MyModified()
    return &ft =~ 'help\|vaffle\|undotree\|nerdtree\|qf\|quickrun' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
    return &ft !~? 'help\|vaffle\|undotree\|nerdtree\|qf\|quickrun' && &ro ? ' ' : ''
endfunction

function! MyFugitive()
    try
        if &ft !~? 'vaffle\|undotree\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
            let _ = fugitive#head()
            return winwidth('.') > 70 ? strlen(_) ? ' '._ : '' : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyFugitiveInv()
    try
        if &ft !~? 'vaffle\|undotree\|nerdtree\|qf\|quickrun' && exists('*fugitive#head')
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
    return &ft == 'vaffle' ? 'Vaffle' : 
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'denite' ? 'Denite' :
                \ &ft == 'undotree' ? 'UNDOtree' :
                \ &ft == 'nerdtree' ? 'NERDtree' :
                \ &ft == 'qf' ? 'QuickFix' :
                \ &ft == 'quickrun' ? '' :
                \ winwidth('.') > 60 ? lightline#mode() : lightline#mode()[0]
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                \ (&ft == 'unite' ? unite#get_status_string() :
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
    return &ft == 'vaffle' ? '' :
                \ &ft == 'unite' ? '' :
                \ &ft == 'denite' ? '' :
                \ &ft == 'qf' ? '' :
                \ &ft == 'quickrun' ? '' :
                \ tabpagenr('$') > 3 ? '' :
                \ strlen(_) < winwidth('.') / 2 ? _ : ''
endfunction

function! MyRadikoSta()
    if g:radiko#is_loaded
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
    else
        let _ = ''
    endif
    return winwidth('.') > 30 ? strlen(_) ? '♪' . _ : '' : ''
endfunction


" auto-toggle of cursorline
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorcolumn
    autocmd CursorHold,CursorHoldI * setlocal cursorline
    autocmd CursorHold,CursorHoldI * setlocal cursorcolumn
augroup END

" when creating new file, if it does not exist directory,
" this function will ask you to create new directory.
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if match(a:dir, '\(scp://\|http://\|https://\)') == -1
            if !isdirectory(a:dir) && (a:force ||
                        \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
                call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
            endif
        endif
    endfunction
augroup END

" load Session.vim
augroup vimrc-session-vim-auto-load
    autocmd!
    autocmd VimEnter * nested call <SID>load_session_vim(expand('<afile>:p:h'))
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

" load .vimrc.local automatically
augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call <SID>vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

