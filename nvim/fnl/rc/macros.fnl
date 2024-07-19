;; [nfnl-macro]

(fn time! [...]
  `(let [start# (vim.loop.hrtime)
         result# (do ,...)
         end# (vim.loop.hrtime)]
     (print (.. "Elapsed time: " (/ (- end# start#) 1000000) " msecs"))
     result#))

(fn map! [modes from to opts]
  (let [out []]
    (each [_ mode (ipairs modes)]
      (table.insert
        out
        `(vim.keymap.set ,mode ,from ,to ,opts)))
    (if (> (length out) 1)
      `(do ,(unpack out))
      `,(unpack out))))

(fn augroup! [name ...]
  `(let [group# (vim.api.nvim_create_augroup
                  ,(tostring name)
                  {:clear true})]
     ,(let [cmds (icollect [_ cmd (ipairs [...])]
                   `(vim.api.nvim_create_autocmd
                      ,cmd.events
                      {:pattern ,cmd.pattern
                       :group group#
                       :buffer ,cmd.buffer
                       :command ,cmd.command
                       :callback ,cmd.callback}))]
         (if (> (length cmds) 1)
             `(do ,(unpack cmds))
             `,(unpack cmds)))))

(fn hi! [name opts]
  (let [f (fn [k v]
            (if (= k :fg)
                (let [fg (. opts :fg)]
                  `(.. "ctermfg=" ,fg " guifg=" ,fg))
                (= k :bg)
                (let [bg (. opts :bg)]
                  `(.. "ctermbg=" ,bg " guibg=" ,bg))
                `(.. ,(tostring k) "=" ,v)))
        args (accumulate
               [args name
                k v (pairs opts)]
               `(.. ,args " " ,(f k v)))]
    `(vim.cmd (.. "highlight " ,args))))

(fn ->viml! [name]
  `(.. "lua require('" *module-name* "')['" ,(tostring name) "']()"))

{: time!
 : map!
 : augroup!
 : hi!
 : ->viml!}
