let s:extfname = expand("%:e")
if s:extfname ==? "f90"
    let fortran_free_source=1
    unlet! fortran_fixed_source

    setl softtabstop=2
    setl tabstop=2
    setl shiftwidth=2

    let b:fortran_do_enddo=1
elseif s:extfname ==? "f"
    let fortran_fixed_source=1
    unlet! fortran_free_source
endif

    " let fortran_more_precise=1
" else
"     let fortran_fixed_source=1
"     unlet! fortran_free_source
" endif
"
"
