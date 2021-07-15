{:autocmd
 (fn [...]
   `(nvim.ex.autocmd ,...))

 :augroup
 (fn [name ...]
   `(do
      (nvim.ex.augroup ,(tostring name))
      (nvim.ex.autocmd_)
      (do
        ,...)
      (nvim.ex.augroup :END)))

 :->viml
 (fn [name]
   `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))}
