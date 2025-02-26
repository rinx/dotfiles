(local snacks (require :snacks))

(import-macros {: map!} :rc.macros)

(snacks.setup
  {:bigfile
   {:enabled true}
   :image
   {:enabled true}
   :notifier
   {:enabled true}
   :quickfile
   {:enabled true}
   :terminal
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

(fn map-> [toggle key]
  (toggle:map key))

(map-> (snacks.toggle.option :spell {:name :spelling}) :<leader>s)
(map-> (snacks.toggle.option :paste {:name :Paste}) :<leader>p)
(map-> (snacks.toggle.option :relativenumber {:name "Relative number"}) :<leader>r)
(map-> (snacks.toggle.inlay_hints) :<leader>i)

(map! [:n]
      :<leader>w
      ":<C-u>lua Snacks.terminal.toggle()<CR>"
      {:silent true
       :desc "Open/Close terminal"})
