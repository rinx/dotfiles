(local snacks (require :snacks))

(import-macros {: map!} :rc.macros)

(snacks.setup
  {:bigfile
   {:enabled true}
   :image
   {:enabled true}
   :input {}
   :notifier
   {:enabled true}
   :picker {}
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

;; terminal
(map! [:n]
      :<leader>w
      ":<C-u>lua Snacks.terminal.toggle()<CR>"
      {:silent true
       :desc "Open/Close terminal"})

;; picker
(map! [:n]
      :<leader>t
      ":<C-u>lua Snacks.picker.explorer()<CR>"
      {:silent true
       :desc "Open/Close explorer"})

(map! [:n]
      ",b"
      ":<C-u>lua Snacks.picker.buffers()<CR>"
      {:silent true
       :desc "select buffer via snacks.picker"})
(map! [:n]
      ",c"
      ":<C-u>lua Snacks.picker.command_history()<CR>"
      {:silent true
       :desc "select command from history via snacks.picker"})
(map! [:n]
      ",f"
      ":<C-u>lua Snacks.picker.files()<CR>"
      {:silent true
       :desc "select file via snacks.picker"})
(map! [:n]
      ",af"
      ":<C-u>lua Snacks.picker.files({ hidden = true, ignored = true })<CR>"
      {:silent true
       :desc "select all file via snacks.picker"})
(map! [:n]
      ",g"
      ":<C-u>lua Snacks.picker.grep()<CR>"
      {:silent true
       :desc "live grep via snacks.picker"})
(map! [:n]
      ",gf"
      ":<C-u>lua Snacks.picker.git_files()<CR>"
      {:silent true
       :desc "select git file via snacks.picker"})
(map! [:n]
      ",gb"
      ":<C-u>lua Snacks.picker.git_branches()<CR>"
      {:silent true
       :desc "switch git branch via snacks.picker"})
(map! [:n]
      ",gc"
      ":<C-u>lua Snacks.picker.git_log()<CR>"
      {:silent true
       :desc "select git commit via snacks.picker"})
(map! [:n]
      ",h"
      ":<C-u>lua Snacks.picker.help()<CR>"
      {:silent true
       :desc "search helptags via snacks.picker"})
(map! [:n]
      ",/"
      ":<C-u>lua Snacks.picker.lines()<CR>"
      {:silent true
       :desc "line search via snacks.picker"})
(map! [:n]
      :<Leader><Leader>
      ":<C-u>lua Snacks.picker.commands()<CR>"
      {:silent true
       :desc "select commands via snacks.picker"})
(map! [:n]
      :<C-\>
      ":<C-u>lua Snacks.picker()<CR>"
      {:silent true
       :desc "select snacks.picker source"})
