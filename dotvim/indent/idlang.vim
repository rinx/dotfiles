" IDL indent file
" modified from original vim73

if exists('b:did_indent')
    finish
endif

setl autoindent
setl indentexpr=GetIDLIndent()
setl indentkeys=!^F,o,O,0=end,0=END,0=endif,0=ENDIF,0=endelse,0=ENDELSE,0=endwhile,0=ENDWHILE,0=endfor,0=ENDFOR,0=endforeach,0=ENDFOREACH,0=endrep,0=ENDREP

setl expandtab
setl tabstop<
setl softtabstop=2
setl shiftwidth=2

let b:undo_indent = 'setlocal '.join([
\   'autoindent<',
\   'expandtab<',
\   'indentexpr<',
\   'indentkeys<',
\   'shiftwidth<',
\   'softtabstop<',
\ ])

function! GetIDLIndent()
    " First non-empty line above the current line.
    let pnum = prevnonblank(v:lnum-1)
    " v:lnum is the first non-empty line -- zero indent.
    if pnum == 0
        return 0
    endif
    " Second non-empty line above the current line.
    let pnum2 = prevnonblank(pnum-1)

    " Current indent.
    let curind = indent(pnum)

    " Indenting of procedure head.
    if getline(pnum) =~ '^\s*pro\s*.*$'
        let curind = curind + &sw
    endif

    " Indenting of continued lines.
    if getline(pnum) =~ '\$\s*\(;.*\)\=$'
        if getline(pnum2) !~ '\$\s*\(;.*\)\=$'
            let curind = curind + &sw
        endif
    else
        if getline(pnum2) =~ '\$\s*\(;.*\)\=$'
            let curind = curind - &sw
        endif
    endif

    " Indenting blocks of statements.
    if getline(v:lnum) =~? '^\s*\(end\|endif\|endelse\|endwhile\|endfor\|endforeach\|endrep\)\>'
        if getline(pnum) =~? 'begin\>'
        elseif indent(v:lnum) > curind - &sw
            let curind = curinda - &sw
        else
            return -1
        endif
    elseif getline(pnum) =~? 'begin\>'
        if indent(v:lnum) < curind + &sw
            let curind = curind + &sw
        else
            return -1
        endif
    endif

    return curind

endfunction

let b:did_indent=1

