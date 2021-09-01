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

(fn map! [modes from to ...]
  (let [opts (collect [_ opt (ipairs [...])]
               (values (tostring opt) true))
        out []]
    (each [_ mode (ipairs modes)]
      (table.insert out `(nvim.set_keymap ,mode ,from ,to ,opts)))
    (if (> (length out) 1)
      `(do ,(unpack out))
      `,(unpack out))))

(fn noremap! [modes from to ...]
  `(map! ,modes ,from ,to :noremap ,...))

{: autocmd!
 : augroup!
 : ->viml!
 : map!
 : noremap!}
