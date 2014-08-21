" --- functions ---

"A function to convert csv to markdown
function! s:csv_to_markdown_table () range
    for i in range(a:firstline, a:lastline)
       call setline(i, '| ' . substitute(getline(i), '\s*\,\s*', ' | ', 'g') . ' |')
    endfor
endfunction

command! -range CsvToMarkdownTable <line1>,<line2>call s:csv_to_markdown_table()


