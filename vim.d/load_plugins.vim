" --- load plugin settings ---

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc(expand('~/.vim/bundle/'))

"github repositories
NeoBundleFetch 'Shougo/neobundle.vim'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
    let g:make = 'make'
endif
NeoBundle 'Shougo/vimproc.vim'

if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
    NeoBundleLazy 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundleLazy 'Shougo/neocomplcache.vim'
endif

NeoBundleLazy 'Shougo/neosnippet'
NeoBundleLazy 'Shougo/neosnippet-snippets', { 'depends' : 'Shougo/neosnippet' }
NeoBundleLazy 'honza/vim-snippets', { 'depends' : 'Shougo/neosnippet' }

NeoBundleLazy 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/vimshell.vim'

NeoBundle 'kana/vim-submode'
NeoBundle 'kana/vim-arpeggio'
NeoBundle 'kana/vim-altercmd'

NeoBundleLazy 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/neomru.vim', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'thinca/vim-unite-history', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'Shougo/unite-outline', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'tsukkee/unite-help', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'osyo-manga/unite-filetype', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'kmnk/vim-unite-giti', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'tacroe/unite-mark', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'moznion/unite-git-conflict.vim', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'haya14busa/unite-reading-vimrc', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'pasela/unite-webcolorname', { 'depends' : 'Shougo/unite.vim' }

NeoBundle 'itchyny/lightline.vim'

NeoBundle 'tyru/skk.vim'
NeoBundleFetch 'tyru/eskk.vim'

NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'osyo-manga/unite-quickrun_config', {
            \ 'depends' : [
            \   'Shougo/unite.vim',
            \   'thinca/vim-quickrun',
            \ ]
            \}

NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs', {
            \ 'depends' : [
            \   'thinca/vim-quickrun',
            \   'Shougo/vimproc.vim',
            \   'osyo-manga/shabadou.vim',
            \   'jceb/vim-hier',
            \ ]
            \}
NeoBundleLazy 'jceb/vim-hier'

NeoBundle 'ynkdir/vim-vimlparser'
NeoBundle 'syngan/vim-vimlint', { 'depends' : 'ynkdir/vim-vimlparser' }

NeoBundle 'vim-scripts/eregex.vim'

NeoBundle 'tmhedberg/matchit'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'airblade/vim-gitgutter'

NeoBundleLazy 'sjl/gundo.vim'
NeoBundleLazy 'scrooloose/nerdtree'

NeoBundleLazy 'LeafCage/yankround.vim'

NeoBundleLazy 'haya14busa/incsearch.vim'
NeoBundle 'haya14busa/vim-migemo'

NeoBundleLazy 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-over'
NeoBundleLazy 'thinca/vim-visualstar'

NeoBundle 'rhysd/clever-f.vim'

NeoBundleLazy 'thinca/vim-qfreplace'

NeoBundleLazy 't9md/vim-quickhl'

NeoBundle 'amdt/vim-niji'

NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-operator-replace', { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'emonkak/vim-operator-comment', { 'depends' : 'kana/vim-operator-user' }
NeoBundle 'rhysd/vim-operator-surround', { 'depends' : 'kana/vim-operator-user' }

NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-function', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-entire', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-line', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'kana/vim-textobj-jabraces', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'lucapette/vim-textobj-underscore', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'mattn/vim-textobj-url', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'osyo-manga/vim-textobj-multiblock', { 'depends' : 'kana/vim-textobj-user' }
NeoBundle 'osyo-manga/vim-textobj-multitextobj', { 'depends' : 'kana/vim-textobj-user' }
NeoBundleLazy 'rhysd/vim-textobj-ruby', { 'depends' : 'kana/vim-textobj-user' }

NeoBundleLazy 'terryma/vim-expand-region'

NeoBundleLazy 'tyru/capture.vim'

NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'tyru/open-browser-github.vim', { 'depends' : 'tyru/open-browser.vim' }

NeoBundleLazy 'kannokanno/previm', { 'depends' : 'tyru/open-browser.vim' }

NeoBundleLazy 'basyura/unite-rails', { 'depends' : 'Shougo/unite.vim' }

NeoBundleLazy 'eagletmt/ghcmod-vim'
NeoBundleLazy 'eagletmt/neco-ghc'
NeoBundleLazy 'dag/vim2hs'
NeoBundleLazy 'ujihisa/ref-hoogle'
NeoBundleLazy 'ujihisa/unite-haskellimport'
NeoBundleLazy 'pbrisbin/html-template-syntax'

NeoBundleLazy 'mattn/emmet-vim'

NeoBundleLazy 'elzr/vim-json'

NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'mattn/learn-vimscript'

NeoBundleLazy 'mattn/webapi-vim'
NeoBundleLazy 'moznion/hateblo.vim', { 'depends' : ['mattn/webapi-vim', 'Shougo/unite.vim'] }
NeoBundleLazy 'basyura/twibill.vim', { 'depends' : 'tyru/open-browser.vim' }
NeoBundleLazy 'basyura/TweetVim', {
            \ 'depends' : [
            \   'tyru/open-browser.vim',
            \   'basyura/twibill.vim',
            \   'basyura/bitly.vim',
            \   'mattn/webapi-vim',
            \   'mattn/favstar-vim',
            \   'Shougo/unite.vim',
            \   'Shougo/unite-outline',
            \ ]
            \}
NeoBundleLazy 'basyura/bitly.vim'
NeoBundleLazy 'mattn/favstar-vim'
NeoBundleLazy 'basyura/J6uil.vim', {
            \ 'depends' : [
            \   'tyru/open-browser.vim',
            \   'Shougo/vimproc.vim',
            \   'Shougo/unite.vim',
            \ ]
            \}

NeoBundleLazy 'lambdalisue/vim-gista', { 'depends' : 'Shougo/unite.vim' }

NeoBundleLazy 'koron/codic-vim'
NeoBundleLazy 'rhysd/unite-codic.vim', { 'depends' : ['Shougo/unite.vim', 'koron/codic-vim'] }

NeoBundleLazy 'supermomonga/jazzradio.vim', { 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'supermomonga/skyfm.vim', { 'depends' : 'Shougo/unite.vim' }



"Plugin settings

if neobundle#tap('vimproc.vim')
    call neobundle#config({
                \ 'build' : {
                \   'windows' : 'make -f make_mingw32.mak',
                \   'mac' : 'make -f make_mac.mak',
                \   'unix' : 'make -f make_unix.mak',
                \ },
                \})
    call neobundle#untap()
endif

if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
    "neocomplete
    if neobundle#tap('neocomplete.vim')
        call neobundle#config({
                    \ 'autoload' : {
                    \   'insert' : 1,
                    \ }
                    \})

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
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif

        let g:neocomplete#enable_auto_close_preview = 1

        inoremap <expr><C-g> neocomplete#undo_completion()
        inoremap <expr><C-l> neocomplete#complete_common_string()

        call neobundle#untap()
    endif
else
    "neocomplcache
    if neobundle#tap('neocomplcache.vim')
        call neobundle#config({
                    \ 'autoload' : {
                    \   'insert' : 1,
                    \ }
                    \})

        let g:neocomplcache_enable_at_startup = 1
        let g:neocomplcache_auto_completion_start_length = 1
        let g:neocomplcache_enable_smart_case = 1
        let g:neocomplcache_enable_underbar_completion = 1

        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif

        call neobundle#untap()
    endif
endif

"Enable omni function
augroup vimrc-omnifuncs
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

if neobundle#tap('neosnippet')
    call neobundle#config({
                \ 'autoload' : {
                \   'insert' : 1,
                \ }
                \})

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
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif

    call neobundle#untap()
endif

if neobundle#tap('neosnippet-snippets')
    call neobundle#config({
                \ 'autoload' : {
                \   'insert' : 1,
                \ }
                \})

    call neobundle#untap()
endif

if neobundle#tap('vim-snippets')
    call neobundle#config({
                \ 'autoload' : {
                \   'insert' : 1,
                \ }
                \})

    call neobundle#untap()
endif

if neobundle#tap('vimfiler.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'VimFilerTab',
                \     'VimFiler',
                \     'VimFilerExplorer'
                \   ]
                \ }
                \})
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:vimfiler_force_overwrite_statusline = 0
    endfunction
    call neobundle#untap()
endif

if neobundle#tap('vimshell.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'VimShell',
                \     'VimShellPop',
                \     'VimShellInteractive'
                \   ]
                \ }
                \})
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:vimshell_force_overwrite_statusline = 0
    endfunction
    call neobundle#untap()
endif

if neobundle#tap('vim-arpeggio')
    call arpeggio#load()
    call neobundle#untap()
endif

if neobundle#tap('unite.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Unite',
                \     'UniteWithBufferDir',
                \     'UniteWithCurrentDir',
                \     'UniteResume',
                \   ]
                \ }
                \})
    function! neobundle#tapped.hooks.on_source(bundle)
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
                    \ ['unite-neobundle', 'Unite neobundle'],
                    \ ['neobundle update', 'NeoBundleUpdate'],
                    \ ['neobundle clean', 'NeoBundleClean'],
                    \ ['unite neosnippet', 'Unite neosnippet'],
                    \ ['unite gista', 'Unite gista'],
                    \ ['unite codic', 'Unite codic -start-insert'],
                    \ ['unite Jazzradio', 'Unite jazzradio'],
                    \ ['stop Jazzradio', 'JazzradioStop'],
                    \ ['unite Sky.fm', 'Unite skyfm'],
                    \ ['stop Sky.fm', 'SkyfmStop'],
                    \ ['TweetVim home-timeline', 'TweetVimHomeTimeline'],
                    \ ['TweetVim UserStream', 'TweetVimUserStream'],
                    \ ['J6uil lingr-client', 'J6uil'],
                    \ ['hateblo list', 'HatebloList'],
                    \ ['copy buffer into clipboard', s:copyToClipboardCommand],
                    \ ['lingr', 'http://lingr.com/'],
                    \ ['vim-jp', 'http://vim-jp.org/'],
                    \ ['reading-vimrc', 'http://vim-jp.org/reading-vimrc/'],
                    \ ['Github', 'https://github.com/'],
                    \ ['Github Gist', 'https://gist.github.com/'],
                    \ ['Japan Meteorological Agency(JMA)', 'http://www.jma.go.jp/'],
                    \ ['stackoverflow', 'http://stackoverflow.com/'],
                    \ ['Grooveshark', 'http://grooveshark.com/'],
                    \ ['Jazzradio', 'http://www.jazzradio.com/'],
                    \ ['SKY.FM radio', 'http://www.sky.fm/'],
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
                    \["beer", "Ʊ\"-ʓ"],
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

    call neobundle#untap()
endif

if neobundle#tap('neomru.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'file_mru',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-unite-history')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'history/command',
                \     'history/search',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-outline')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'outline',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-help')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'help',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-filetype')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'filetype',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-unite-giti')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Giti',
                \     'GitiWithConfirm',
                \     'GitiFetch',
                \     'GitiPush',
                \     'GitiPushWithSettingUpstream',
                \     'GitiPushExpressly',
                \     'GitiPull',
                \     'GitiPullSquash',
                \     'GitiPullRebase',
                \     'GitiPullExpressly',
                \     'GitiDiff',
                \     'GitiDiffCached',
                \     'GitiLog',
                \     'GitiLogLine',
                \   ],
                \   'unite_sources' : [
                \     'giti',
                \     'giti/branch',
                \     'giti/config',
                \     'giti/log',
                \     'giti/remote',
                \     'giti/status',
                \   ]
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-mark')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'mark',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-git-conflict.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'git-conflict',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-reading-vimrc')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'reading-vimrc',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-webcolorname')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'webcolorname',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('skk.vim')
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

    call neobundle#untap()
endif

if neobundle#tap('eskk.vim')
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
endif

if neobundle#tap('vim-quickrun')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'QuickRun',
                \   ],
                \   'mappings' : [
                \     '<Plug>(quickrun',
                \   ],
                \ }
                \})
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
                \   'type' : 'make',
                \ },
                \ 'watchdogs_checker/_' : {
                \   'outputter' : 'quickfix',
                \   'runner/vimproc/updatetime' : 40,
                \ },
                \}
    nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
    Arpeggio nmap qr <Plug>(quickrun)
    augroup vimrc-forQuickRun
        autocmd!
        autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&filetype')) == 'quickrun' | q | endif
    augroup END
    call neobundle#untap()
endif

if neobundle#tap('unite-quickrun_config')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'quickrun_config',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-watchdogs')
    call watchdogs#setup(g:quickrun_config)

    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_BufWritePost_enables = {
                \}
    let g:watchdogs_check_CursorHold_enable = 0
    let g:watchdogs_check_CursorHold_enables = {
                \}

    call neobundle#untap()
endif

if neobundle#tap('vim-hier')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'HierStart',
                \     'HierStop',
                \     'HierUpdate',
                \     'HierClear',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-gitgutter')
    let g:gitgutter_map_keys = 0
    let g:gitgutter_sign_added = '✚'
    let g:gitgutter_sign_modified = '➜'
    let g:gitgutter_sign_removed = '✘'
    call neobundle#untap()
endif

if neobundle#tap('gundo.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'GundoToggle',
                \   ],
                \ }
                \})
    nnoremap <F5> :<C-u>GundoToggle<CR>
    let g:gundo_width = 45
    let g:gundo_preview_height = 15
    let g:gundo_right = 0
    let g:gundo_help = 1
    let g:gundo_map_move_older = "j"
    let g:gundo_map_move_newer = "k"
    let g:gundo_close_on_revert = 1
    let g:gundo_auto_preview = 1
    let g:gundo_playback_delay = 100
    call neobundle#untap()
endif

if neobundle#tap('nerdtree')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'NERDTree',
                \     'NERDTreeFromBookmark',
                \     'NERDTreeToggle',
                \     'NERDTreeMirror',
                \     'NERDTreeClose',
                \     'NERDTreeFind',
                \     'NERDTreeCWD',
                \   ]
                \ }
                \})
    nnoremap <F6> :<C-u>NERDTreeToggle<CR>
    augroup vimrc-nerdtree
        autocmd!
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    augroup END
    call neobundle#untap()
endif

if neobundle#tap('yankround.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(yankround-',
                \   ],
                \ }
                \})

    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap gp <Plug>(yankround-gp)
    nmap gP <Plug>(yankround-gP)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)

    let g:yankround_max_history = 35
    let g:yankround_use_region_hl = 1

    call neobundle#untap()
endif


if neobundle#tap('incsearch.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(incsearch-',
                \   ],
                \ },
                \})
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <plug>(incsearch-stay)

    call neobundle#untap()
endif

if neobundle#tap('vim-anzu')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(anzu-',
                \   ],
                \ }
                \})
    nmap n <Plug>(anzu-n)zz
    nmap N <Plug>(anzu-N)zz
    nmap * <Plug>(anzu-star)zz
    nmap # <Plug>(anzu-sharp)zz
    augroup vimrc-anzu
        autocmd!
        autocmd CursorHold,CursorHoldI,WinLeave,Tableave * call anzu#clear_search_status()
    augroup END

    call neobundle#untap()
endif

if neobundle#tap('vim-visualstar')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(visualstar-',
                \   ],
                \ }
                \})

    map * <Plug>(visualstar-*)
    map # <Plug>(visualstar-#)
    map g* <Plug>(visualstar-g*)
    map g# <Plug>(visualstar-g#)

    call neobundle#untap()
endif

if neobundle#tap('clever-f.vim')
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

    call neobundle#untap()
endif

if neobundle#tap('vim-qfreplace')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Qfreplace',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-quickhl')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(quickhl-',
                \   ],
                \ }
                \})
    nmap <Space>m <Plug>(quickhl-manual-this)
    xmap <Space>m <Plug>(quickhl-manual-this)
    nmap <Space>M <Plug>(quickhl-manual-reset)
    xmap <Space>M <Plug>(quickhl-manual-reset)

    call neobundle#untap()
endif

if neobundle#tap('vim-niji')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'lisp',
                \     'scheme',
                \     'clojure',
                \   ],
                \ },
                \})
    let g:niji_matching_filetypes = [
                \ 'lisp',
                \ 'scheme',
                \ 'clojure',
                \ ]
    call neobundle#untap()
endif

"operator

if neobundle#tap('vim-operator-comment')
    Arpeggio map oc <Plug>(operator-comment)
    Arpeggio map od <Plug>(operator-uncomment)

    call neobundle#untap()
endif

if neobundle#tap('vim-operator-replace')
    Arpeggio map or <Plug>(operator-replace)

    call neobundle#untap()
endif

if neobundle#tap('vim-operator-surround')
    map Sa <Plug>(operator-surround-append)
    map Sd <Plug>(operator-surround-delete)
    map Sr <Plug>(operator-surround-replace)

    call neobundle#untap()
endif


"textobj
if neobundle#tap('vim-textobj-jabraces')
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

    call neobundle#untap()
endif

if neobundle#tap('vim-textobj-multiblock')
    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    vmap ab <Plug>(textobj-multiblock-a)
    vmap ib <Plug>(textobj-multiblock-i)

    call neobundle#untap()
endif

if neobundle#tap('vim-textobj-multitextobj')
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

    call neobundle#untap()
endif

if neobundle#tap('vim-textobj-ruby')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'ruby',
                \   ],
                \ },
                \})
    let g:textobj_ruby_more_mappings = 1

    call neobundle#untap()
endif

if neobundle#tap('vim-expand-region')
    call neobundle#config({
                \ 'autoload' : {
                \   'mappings' : [
                \     '<Plug>(expand_region_',
                \   ],
                \ },
                \})
    map + <Plug>(expand_region_expand)
    map _ <Plug>(expand_region_shrink)

    call neobundle#untap()
endif

if neobundle#tap('capture.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Capture',
                \   ],
                \ }
                \})

    augroup vimrc-capture
        autocmd!
        autocmd FileType capture nnoremap <buffer><silent>q :<C-u>q<CR>
        autocmd WinEnter * if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&filetype')) == 'capture' | q | endif
    augroup END

    call neobundle#untap()
endif

if neobundle#tap('open-browser.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'OpenBrowser',
                \     'OpenBrowserSearch',
                \   ],
                \   'functions' : [
                \     'OpenBrowser',
                \   ],
                \   'filetypes' : [
                \     'markdown',
                \   ],
                \   'mappings' : [
                \     '<Plug>(openbrowser-',
                \   ],
                \ }
                \})

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

    call altercmd#define('weblio', 'OpenBrowserSearch -weblio')
    call altercmd#define('alc', 'OpenBrowserSearch -alc')

    call neobundle#untap()
endif

if neobundle#tap('open-browser-github.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'OpenGithubFile',
                \     'OpenGithubIssue',
                \     'OpenGithubPullReq',
                \   ],
                \ }
                \})

    call neobundle#untap()
endif

if neobundle#tap('previm')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'markdown',
                \   ],
                \   'commands' : [
                \     'PrevimOpen',
                \   ],
                \ },
                \})

    call neobundle#untap()
endif

if neobundle#tap('unite-rails')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'ruby',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('ghcmod-vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'haskell',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('neco-ghc')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'haskell',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim2hs')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'haskell',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('ref-hoogle')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'haskell',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-haskellimport')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'haskellimport',
                \   ],
                \ },
                \})
    call neobundle#untap()
endif

if neobundle#tap('html-template-syntax')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'hamlet',
                \     'cassius',
                \     'lucius',
                \     'julius',
                \   ],
                \   'filename_patterns' : [
                \     '\.hamlet$',
                \     '\.cassius$',
                \     '\.lucius$',
                \     '\.julius$',
                \   ],
                \ }
                \})
    " You should re-open shakesphere files with :e command
    call neobundle#untap()
endif

if neobundle#tap('emmet-vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'html',
                \     'xhtml',
                \     'css',
                \     'sass',
                \     'scss',
                \     'xml',
                \     'markdown',
                \   ]
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('vim-json')
    call neobundle#config({
                \ 'autoload' : {
                \   'filetypes' : [
                \     'json',
                \     'jsonp',
                \   ],
                \   'filename_patterns' : [
                \     '\.json$',
                \     '\.jsonp$',
                \   ],
                \ },
                \})
    " You should re-open json files with :e command
    call neobundle#untap()
endif

if neobundle#tap('vim-ref')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Ref',
                \   ],
                \   'mappings' : [
                \     '<Plug>(ref-',
                \   ],
                \ }
                \})

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

    call neobundle#untap()
endif

if neobundle#tap('learn-vimscript')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'help',
                \   ],
                \   'unite_sources' : [
                \     'help',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('hateblo.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'HatebloCreate',
                \     'HatebloCreateDraft',
                \     'HatebloList',
                \     'HatebloUpdate',
                \     'HatebloDelete',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('TweetVim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'TweetVimVersion',
                \     'TweetVimAddAccount',
                \     'TweetVimSwitchAccount',
                \     'TweetVimHomeTimeline',
                \     'TweetVimMentions',
                \     'TweetVimListStatuses',
                \     'TweetVimUserTimeline',
                \     'TweetVimSay',
                \     'TweetVimUserStream',
                \     'TweetVimCommandSay',
                \     'TweetVimCurrentLineSay',
                \     'TweetVimSearch',
                \   ],
                \   'unite_sources' : [
                \     'tweetvim/account',
                \     'tweetvim',
                \   ],
                \ }
                \})
    let g:tweetvim_tweet_per_page = 50
    let g:tweetvim_display_icon = 0
    call neobundle#untap()
endif

if neobundle#tap('J6uil.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'J6uil',
                \     'J6uilReconnect',
                \     'J6uilDisconnect',
                \   ],
                \   'unite_sources' : [
                \     'J6uil/rooms',
                \     'J6uil/members',
                \   ],
                \ }
                \})
    let g:J6uil_user = 'rinx'

    call neobundle#untap()
endif

if neobundle#tap('vim-gista')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Gista',
                \   ],
                \   'mappings' : [
                \     '<Plug>(gista-',
                \   ],
                \   'unite_sources' : [
                \     'gista',
                \   ],
                \ }
                \})

    let g:gista#github_user = 'rinx'

    call neobundle#untap()
endif

if neobundle#tap('codic-vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'commands' : [
                \     'Codic',
                \   ],
                \   'unite_sources' : [
                \     'codic',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('unite-codic.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'codic',
                \   ],
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('jazzradio.vim')
    call neobundle#config({
                \ 'autoload' : {
                \   'unite_sources' : [
                \     'jazzradio',
                \   ],
                \   'commands' : [
                \     'JazzradioUpdateChannels',
                \     'JazzradioStop',
                \     {
                \       'name' : 'JazzradioPlay',
                \       'complete' : 'customlist,jazzradio#channel_id_complete'
                \     }
                \   ],
                \   'function_prefix' : 'jazzradio',
                \ }
                \})
    call neobundle#untap()
endif

if neobundle#tap('skyfm.vim')
  call neobundle#config({
        \   'autoload' : {
        \     'unite_sources' : [
        \       'skyfm',
        \     ],
        \     'commands' : [
        \       'SkyfmUpdateChannels',
        \       'SkyfmStop',
        \       {
        \         'name' : 'SkyfmPlay',
        \         'complete' : 'customlist,skyfm#channel_key_complete'
        \       }
        \     ],
        \     'function_prefix' : 'skyfm',
        \   }
        \ })
  call neobundle#untap()
endif


