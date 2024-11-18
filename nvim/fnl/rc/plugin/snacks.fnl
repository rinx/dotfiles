(local snacks (require :snacks))

(import-macros {: map!} :rc.macros)

(snacks.setup
  {:terminal
   {:win
    {:style
     {:bo {:filetype :snacks_terminal}
      :wo {}
      :keys
      {:gf (fn [self]
             (let [f (vim.fn.findfile (vim.fn.expand :<cfile>) :**)]
               (if (= f "")
                   (Snacks.notify.warn "No file under cursor")
                   (do
                     (self:hide)
                     (vim.schedule (fn []
                                     (vim.cmd (.. "e " f))))))))
       :term_normal
       {1 :<esc>
        2 (fn [self]
            (vim.cmd :stopinsert))
        :mode :t
        :expr true
        :desc "escape to normal mode"}}}}}})

(map! [:n]
      :<leader>w
      ":<C-u>lua Snacks.terminal.toggle()<CR>"
      {:silent true
       :desc "Open/Close terminal"})
