" --- functions ---

"A function to convert csv to markdown table
function! s:csv_to_markdown_table () range
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


