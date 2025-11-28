(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local snacks (require :snacks))
(local picker-sources (require :snacks.picker.config.sources))
(local trouble-source-snacks (autoload :trouble.sources.snacks))

(import-macros {: map!} :rc.macros)

(snacks.setup
  {:bigfile
   {:enabled true}
   :image
   {:enabled true
    :doc
    {:inline false
     :float true}}
   :input {}
   :indent
   {:enabled true}
   :notifier
   {:enabled true}
   :picker
   {:actions trouble-source-snacks.actions
    :win
    {:input
     {:keys
      {:<c-t>
       {1 :trouble_open
        :mode [:n :i]}}}}}
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
      ":<C-u>lua Snacks.picker.explorer({ hidden = true, ignored = true })<CR>"
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
      ",x"
      ":<C-u>lua Snacks.picker.diagnostics()<CR>"
      {:silent true
       :desc "select diagnostics via snacks.picker"})
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
      ",gg"
      ":<C-u>lua Snacks.picker.git_grep()<CR>"
      {:silent true
       :desc "git-grep via snacks.picker"})
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
      ",r"
      ":<C-u>lua Snacks.picker.resume()<CR>"
      {:silent true
       :desc "resume last picker"})
(map! [:n]
      ",s"
      ":<C-u>lua Snacks.picker.search_history()<CR>"
      {:silent true
       :desc "select search history via snacks.picker"})
(map! [:n]
      ",u"
      ":<C-u>lua Snacks.picker.undo()<CR>"
      {:silent true
       :desc "undo history via snacks.picker"})
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

;; reference: https://github.com/folke/snacks.nvim/blob/eec6503bc0eda50b3151bf2739453aea4cd528b0/lua/snacks/picker/source/grep.lua#L105
(local kensaku-finder
       (fn [opts ctx]
         (if (= ctx.filter.search "")
             (if opts.current-buf
               (let [l (require :snacks.picker.source.lines)]
                 (l.lines opts ctx))
               (fn []))
             (let [cwd (when (not opts.current-buf)
                         (svim.fs.normalize
                           (if (and opts opts.cwd)
                               opts.cwd
                               (or (vim.uv.cwd) :.))))
                   buf (let [buf ctx.filter.current_buf]
                         (if (= buf 0)
                           (vim.api.nvim_get_current_buf)
                           buf))
                   paths (if opts.current-buf
                           (let [name (vim.api.nvim_buf_get_name buf)]
                             (if (vim.uv.fs_stat name)
                              [(svim.fs.normalize name)]
                              []))
                           [])
                   extmarks (when opts.current-buf
                              (let [hl (require :snacks.picker.util.highlight)]
                                (hl.get_highlights
                                  {:buf buf
                                   :extmarks true})))
                   pattern (snacks.picker.util.parse ctx.filter.search)
                   kensaku-pattern (vim.fn.kensaku#query
                                     pattern
                                     {:rxop vim.g.kensaku#rxop#javascript})
                   args (core.concat
                          [:--color=never
                           :--no-heading
                           :--no-ignore
                           :--with-filename
                           :--line-number
                           :--column
                           :--smart-case
                           :--max-columns=500
                           :--max-columns-preview
                           :-g
                           :!.git
                           :--hidden
                           :-L
                           :--
                           kensaku-pattern]
                          paths)
                   proc (require :snacks.picker.source.proc)
                   transform (fn [item]
                               (set item.cwd cwd)
                               (let [(file line col text) (item.text:match "^(.+):(%d+):(%d+):(.*)$")]
                                 (if (not file)
                                     (do
                                       (when (not (item.text:match :WARNING))
                                         (snacks.notify.error (.. "invalid grep output:\n" item.text)))
                                       false)
                                     (if opts.current-buf
                                       (do
                                        (set item.buf buf)
                                        (set item.text text)
                                        (set item.pos [(tonumber line)
                                                       (tonumber (core.dec col))])
                                        (when extmarks
                                          (set item.highlights (core.get extmarks (tonumber line)))))
                                       (do
                                        (set item.line text)
                                        (set item.file file)
                                        (set item.pos [(tonumber line)
                                                       (tonumber (core.dec col))]))))))]

               (proc.proc
                 (ctx:opts
                  {:notify false
                   :cmd :rg
                   :args args
                   :transform transform})
                 ctx)))))

(set picker-sources.kensaku
     {:finder kensaku-finder
      :regex true
      :format :file
      :show_empty true
      :live true
      :supports_live true})
(map! [:n]
      ",k"
      ":<C-u>lua Snacks.picker.kensaku()<CR>"
      {:silent true
       :desc "live kensaku via snacks.picker"})

(set picker-sources.klines
     {:finder kensaku-finder
      :regex true
      :format :lines
      :show_empty true
      :live true
      :supports_live true
      :current-buf true
      :layout
      {:preview :main
       :preset :ivy}})
(map! [:n]
      ",K"
      ":<C-u>lua Snacks.picker.klines()<CR>"
      {:silent true
       :desc "live kensaku for current buffer via snacks.picker"})

(set picker-sources.filetype
     {:items (core.map
               (fn [ft]
                 {:name ft
                  :text ft})
               (vim.fn.getcompletion "" :filetype))
      :source :filetype
      :layout :select
      :format (fn [item]
                (let [util (require :snacks.util)
                      (icon hl) (util.icon item.text :filetype)]
                  [[(.. icon " ") hl]
                   [item.text]]))
      :confirm (fn [picker item]
                 (picker:close)
                 (vim.cmd.set (.. :ft= item.text)))})
(map! [:n]
      ",t"
      ":<C-u>lua Snacks.picker.filetype()<CR>"
      {:silent true
       :desc "select filetype via snacks.picker"})
