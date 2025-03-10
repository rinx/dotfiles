(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local heirline (autoload :heirline))
(local conditions (autoload :heirline.conditions))
(local utils (autoload :heirline.utils))

(local devicons (autoload :nvim-web-devicons))

(local dap (autoload :dap))

(local color (autoload :rc.color))
(local icon (autoload :rc.icon))

(local colors color.colors)
(local icontab icon.tab)

(local palette
       {:bright_bg colors.color2
        :bright_fg colors.color4
        :red colors.error
        :dark_red colors.color8
        :green colors.info
        :blue colors.hint
        :gray colors.color4
        :orange colors.warn
        :purple colors.purple
        :cyan colors.color10
        :diag_warn colors.warn
        :diag_error colors.error
        :diag_hint colors.hint
        :diag_info colors.info
        :git_del colors.color8
        :git_add colors.color13
        :git_change colors.warn})

(local space " ")
(local fill "▊")
(local space-component {:provider space})
(local align-component {:provider "%="})

(local vi-mode-component
       {:init (fn [self]
                (set self.mode (vim.fn.mode 1)))
        :static {:colors {:n colors.info
                          :i colors.error
                          :v colors.color8
                          :V colors.color8
                          ["\22"] colors.color8
                          :c colors.info
                          :s colors.warn
                          :S colors.warn
                          ["\19"] colors.warn
                          :R colors.purple
                          :r colors.purple
                          ["!"] colors.info
                          :t colors.info}}
        :provider fill
        :hl (fn [self]
              (let [m (self.mode:sub 1 1)]
                {:fg (core.get self.colors m)
                 :bg colors.color2
                 :bold true}))
        :update {1 :ModeChanged
                 :pattern "*:*"
                 :callback (vim.schedule_wrap
                             (fn []
                               (vim.cmd :redrawstatus)))}})

(local file-icon-component
       {:init (fn [self]
                (let [filename self.filename
                      extension (vim.fn.fnamemodify filename ":e")
                      (icon color) (devicons.get_icon_color
                                     filename
                                     extension
                                     {:default true})]
                  (set self.icon icon)
                  (set self.icon-color color)))
        :provider (fn [self]
                    (when self.icon
                      self.icon))
        :hl (fn [self]
              {:fg self.icon-color
               :bg colors.color2})})
(local filename-component
       {:provider (fn [self]
                   (let [filename (vim.fn.fnamemodify self.filename ":.")]
                     (if (core.empty? filename)
                         "[No Name]"
                         (if (conditions.width_percent_below (core.count filename) 0.25)
                             filename
                             (let [shortened (vim.fn.pathshorten filename)]
                               (if (conditions.width_percent_below (core.count shortened) 0.25)
                                   shortened
                                   (vim.fn.fnamemodify self.filename ":p:t")))))))
        :hl {:fg colors.hint
             :bg colors.color2
             :bold true}})
(local file-flags-component
       [{:condition (fn []
                      vim.bo.modified)
         :provider (.. space icontab.circle)
         :hl {:fg colors.hint
              :bg colors.color2}}
        {:condition (fn []
                      (or (not vim.bo.modifiable)
                          vim.bo.readonly))
         :provider (.. space icontab.lock)
         :hl {:fg colors.hint
              :bg colors.color2}}])
(local filename-block
       {:init (fn [self]
                (set self.filename (vim.api.nvim_buf_get_name 0)))
        1 file-icon-component
        2 space-component
        3 filename-component
        4 file-flags-component})

(local cwd-component
       {:provider (fn []
                    (let [shorten (fn [cwd]
                                    (if (conditions.width_percent_below
                                          (core.count cwd)
                                          0.25)
                                      cwd
                                      (vim.fn.pathshorten cwd)))
                          trail (fn [cwd]
                                  (if (= (cwd:sub -1) :/)
                                    cwd
                                    (.. cwd :/)))
                          cwd (-> (vim.fn.getcwd 0)
                                  (vim.fn.fnamemodify ":~")
                                  (shorten)
                                  (trail))]
                      (.. icontab.directory space cwd space)))
        :hl {:fg colors.hint}})

(local ruler-component
       {:provider "[%l/%L] "
        :hl {:fg colors.hint
             :bg colors.color2}})

(local scrollbar-component
       {:static {:sbar ["🭶" "🭷" "🭸" "🭹" "🭺" "🭻"]}
        :provider (fn [self]
                    (let [curr-line (core.get (vim.api.nvim_win_get_cursor 0) 1)
                          lines (vim.api.nvim_buf_line_count 0)
                          i (core.inc
                              (math.floor
                                (* (/ (core.dec curr-line) lines)
                                   (core.count self.sbar))))]
                      (string.rep (core.get self.sbar i) 2)))
        :hl {:fg colors.hint
             :bg colors.color2}})

(local lsp-component
       {:condition conditions.lsp_attached
        :update [:LspAttach :LspDetach]
        :provider (fn []
                    (let [clients (-> (vim.lsp.get_clients {:bufnr 0})
                                      (core.count))]
                      (if (>= clients 2)
                          (.. icontab.compas clients)
                          icontab.compas)))
        :on_click {:callback (fn []
                               (vim.defer_fn
                                 (fn []
                                   (vim.cmd :LspInfo))
                                 100))
                   :name :heirline_LSP}
        :hl {:fg colors.info}})

(local diagnostics-component
       {:condition conditions.has_diagnostics
        :init (fn [self]
                (let [dc (fn [severity]
                           (core.count
                             (vim.diagnostic.get 0 {:severity severity})))]
                  (set self.errors (dc vim.diagnostic.severity.ERROR))
                  (set self.warns (dc vim.diagnostic.severity.WARN))
                  (set self.infos (dc vim.diagnostic.severity.INFO))
                  (set self.hints (dc vim.diagnostic.severity.HINT))))
        :update [:DiagnosticChanged :BufEnter :CursorMoved]
        1 {:provider (fn [self]
                       (when (> self.errors 0)
                         (.. icontab.bug self.errors space)))
           :hl {:fg :diag_error}}
        2 {:provider (fn [self]
                      (when (> self.warns 0)
                        (.. icontab.exclam-circle self.warns space)))
           :hl {:fg :diag_warn}}
        3 {:provider (fn [self]
                       (when (> self.infos 0)
                        (.. icontab.info-circle self.infos space)))
           :hl {:fg :diag_info}}
        4 {:provider (fn [self]
                       (when (> self.hints 0)
                         (.. icontab.leaf self.hints space)))
           :hl {:fg :diag_hint}}})

(local git-component
       {:condition conditions.is_git_repo
        :flexible true
        :init (fn [self]
                (set self.status_dict vim.b.gitsigns_status_dict)
                (set self.has_changes
                     (or (~= self.status_dict.added 0)
                         (~= self.status_dict.removed 0)
                         (~= self.status_dict.changed 0))))
        :hl {:fg :purple
             :bg colors.color2}
        1 {:provider (fn [self]
                       (.. icontab.github self.status_dict.head space))
           :hl {:bold true}}
        2 {:provider (fn [self]
                       (let [added (or self.status_dict.added 0)]
                         (when (> added 0)
                           (.. icontab.diff-add added space))))
           :hl {:fg :git_add}}
        3 {:provider (fn [self]
                       (let [deleted (or self.status_dict.removed 0)]
                         (when (> deleted 0)
                           (.. icontab.diff-removed deleted space))))
           :hl {:fg :git_del}}
        4 {:provider (fn [self]
                       (let [changed (or self.status_dict.changed 0)]
                         (when (> changed 0)
                           (.. icontab.diff-modified changed space))))
           :hl {:fg :git_change}}})

(local dap-component
       {:condition (fn []
                     (let [session (dap.session)]
                       (~= session nil)))
        :provider (fn []
                    (.. icontab.play-circle space (dap.status)))
        :hl {:fg colors.color4}})

(local denops-component
       {:provider (fn []
                    (match (vim.fn.denops#server#status)
                      :running (.. icontab.dinosaur space)
                      _ ""))
        :hl {:fg colors.color4
             :bg colors.color2}})

(local skkeleton-component
       {:provider (fn []
                    (let [mode (match (vim.fn.skkeleton#mode)
                                :hira "あ"
                                :kata "ア"
                                :hankata "ｧｱ"
                                :ascii "aA"
                                :zenei "ａ"
                                :abbrev "aあ"
                                _ nil)]
                      (when mode
                        (.. icontab.cursor-text mode space))))
        :hl {:fg colors.color10
             :bg colors.color2}})

(local spell-component
       {:condition (fn []
                     vim.wo.spell)
        :provider (fn []
                    (.. icontab.spellcheck vim.o.spelllang space))
        :hl {:fg colors.hint
             :bg colors.color2}})

(local paste-component
       {:condition (fn []
                    vim.o.paste)
        :provider (.. icontab.paste space)
        :hl {:fg colors.hint
             :bg colors.color2}})

(local search-component
       {:condition (fn []
                     (~= vim.v.hlsearch 0))
        :init (fn [self]
                (let [(ok search) (pcall vim.fn.searchcount)
                      word (vim.fn.getreg :/)]
                  (when (and ok search.total)
                    (set self.search search)
                    (set self.word word))))
        :provider (fn [self]
                    (string.format
                      (.. icontab.search
                          self.word
                          "[%d/%d]"
                          space)
                      self.search.current
                      (math.min
                        self.search.total
                        self.search.maxcount)))
        :hl {:fg colors.hint
             :bg colors.color2}})

(local macrorec-component
       {:condition (fn []
                     (~= (vim.fn.reg_recording) ""))
        :provider (fn []
                    (.. icontab.recording
                        "["
                        (vim.fn.reg_recording)
                        "]"
                        space))
        :hl {:fg colors.info
             :bg colors.color2}
        :update [:RecordingEnter :RecordingLeave]})

(local copilot-component

       {:condition (fn []
                     (~= (core.get package.loaded :copilot) nil))
        :provider (fn []
                      (let [copilot (require :copilot.client)
                            api (require :copilot.api)]
                        (if (or (not (copilot.buf_is_attached (vim.api.nvim_get_current_buf)))
                                (copilot.is_disabled))
                            icontab.copilot-disabled
                            (if (= api.status.data.status :Warning)
                                icontab.copilot-warning
                                (if vim.b.copilot_suggestion_auto_trigger
                                    icontab.copilot-sleep
                                    icontab.copilot-enabled)))))
        :hl {:fg colors.hint
             :bg colors.color2}})

(local default-statusline
       [vi-mode-component
        space-component
        filename-block
        align-component
        search-component
        macrorec-component
        align-component
        git-component
        skkeleton-component
        denops-component
        spell-component
        paste-component
        ruler-component
        scrollbar-component])

(local standard-winbar
       [cwd-component
        align-component
        dap-component
        align-component
        copilot-component
        diagnostics-component
        lsp-component])

(heirline.setup
  {:statusline [default-statusline]
   :winbar [standard-winbar]
   :opts {:colors palette
          :disable_winbar_cb (fn [args]
                               (conditions.buffer_matches
                                 {:buftype [:nofile
                                            :prompt
                                            :help
                                            :quickfix
                                            :^terminal$]
                                  :filetype ["^git.*"
                                             :Trouble
                                             :^dap-repl$
                                             :^dapui_watches$
                                             :^dapui_stacks$
                                             :^dapui_breakpoints$
                                             :^dapui_scopes$
                                             :^NvimTree$]}))}})
