" Statusline settings

set laststatus=2

if neobundle#tap('lightline.vim')
    let g:lightline = {
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'fugitive', 'filename' ]
                \   ],
                \   'right': [ [ 'syntastic', 'lineinfo' ],
                \             [ 'percent' ],
                \             [ 'skkstatus', 'anzu', 'fileformat', 'fileencoding', 'filetype' ]
                \   ]
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
                \   'anzu': 'anzu#search_status'
                \ },
                \ 'component_expand': {
                \   'syntastic': 'SyntasticStatuslineFlag'
                \ },
                \ 'component_type': {
                \   'syntastic': 'error'
                \ }
                \ }

    function! MyModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &ro ? ' ' : ''
    endfunction

    function! MyFugitive()
        try
            if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
                let _ = fugitive#head()
                return strlen(_) ? ' '._ : ''
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
                    \ winwidth('.') > 60 ? lightline#mode() : ''
    endfunction

    function! MyFilename()
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? substitute(b:vimshell.current_dir,expand('~'),'~','') :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MySkkgetmode()
        let _ = SkkGetModeStr()
        return strlen(_) ? substitute(_, '\[\|\]', '', 'g') : ''
    endfunction

    call neobundle#untap()
endif
