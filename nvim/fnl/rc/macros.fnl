(fn autocmd! [...]
  `(nvim.ex.autocmd ,...))

(fn augroup! [name ...]
  `(do
     (nvim.ex.augroup ,(tostring name))
     (nvim.ex.autocmd_)
     (do
       ,...)
     (nvim.ex.augroup :END)))

(fn ->viml! [name]
  `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))

{: autocmd!
 : augroup!
 : ->viml!}
