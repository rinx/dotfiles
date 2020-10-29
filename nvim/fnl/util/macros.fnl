{:autocmd
 (fn [...]
   `(nvim.ex.autocmd ,...))

 :augroup
 (fn [name ...]
   `(do
      (nvim.ex.augroup ,(tostring name))
      (nvim.ex.autocmd_)
      ,...
      (nvim.ex.augroup :END)))}
