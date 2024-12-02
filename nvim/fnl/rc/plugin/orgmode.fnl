(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local icon (autoload :rc.icon))
(local color (autoload :rc.color))

(local icontab icon.tab)
(local colors color.colors)

(local orgmode (require :orgmode))
(local roam (require :org-roam))
(local bullets (require :org-bullets))
(local modern-menu (require :org-modern.menu))

(local basepath (vim.fn.expand "~/notes/org"))
(local templates
       ;; get current filepath and concatinate
       (let [info (debug.getinfo 1)]
         (vim.fn.expand
           (.. (vim.fn.fnamemodify (info.source:sub 2) ":h")
               :/../../../orgmode/templates))))

(fn ->path [path]
  (.. basepath :/ path))
(fn ->tmpl [path]
  (.. templates :/ path))

(fn ->tmplstr [path]
  (vim.fn.join
    (vim.fn.readfile (->tmpl path))
    "\n"))

(local inbox (->path :inbox.org))

(when (not (= (vim.fn.isdirectory basepath) 1))
  (vim.fn.mkdir basepath :p))
(when (not (= (vim.fn.filereadable inbox) 1))
  (vim.fn.writefile
    (vim.fn.readfile (->tmpl :inbox.org))
    inbox))

(orgmode.setup
  {:org_agenda_files [inbox
                      (->path :journal/*.org)
                      (->path :notes/**/*.org)]
   :org_default_notes_file inbox
   :org_archive_location (->path "archive/%s_archive::")
   :org_todo_keywords [:TODO
                       :WAITING
                       :PENDING
                       :IN_REVIEW
                       :|
                       :DONE
                       :CANCELED]
   :org_todo_keyword_faces
   {:TODO (.. ":foreground " colors.color5 " :background " colors.color8 " :underline on")
    :WAITING (.. ":foreground " colors.color5 " :background " colors.color10)
    :PENDING (.. ":foreground " colors.color5 " :background " colors.color10)
    :IN_REVIEW (.. ":foreground " colors.color5 " :background " colors.color10)
    :DONE (.. ":foreground " colors.color5 " :background " colors.color13)
    :CANCELED (.. ":foreground " colors.color5 " :background " colors.color9)}
   :org_startup_folded :overview
   :org_capture_templates
   {:t {:description " Add a new task to inbox"
        :template (->tmplstr :task.org)
        :target inbox
        :headline :Tasks}
    :n {:description " Add a new note to inbox"
        :subtemplates
        {:c {:description "󰅴 code-reading note"
             ;; TODO: add link to github in template
             :template (->tmplstr :code-note.org)
             :target inbox
             :headline :Notes}
         :d {:description " default note"
             :template (->tmplstr :note.org)
             :target inbox
             :headline :Notes}
         :l {:description " with link"
             :template (->tmplstr :link.org)
             :target inbox
             :headline :Notes}
         :p {:description " with clipboard content"
             :template (->tmplstr :paste.org)
             :target inbox
             :headline :Notes}}}
    :i {:description " Add a new idea"
        :template (->tmplstr :idea.org)
        :target inbox
        :headline :Ideas}
    :s {:description " Add a new topic"
        :template (->tmplstr :topic.org)
        :target inbox
        :headline :Topics}
    :j {:description "󰃭 Add a new note to journal"
        :template (->tmplstr :journal.org)
        :target (->path :journal/%<%Y-%m>.org)
        :datetree {:tree_type :day}}}
   :calendar_week_start_day 0
   :org_deadline_warning_days 7
   :org_tags_column 90
   :org_id_link_to_org_use_id true
   :org_custom_exports
   {:g
    {:label "Export to GitHub flavored markdown"
     :action (fn [exporter]
               (let [current (vim.api.nvim_buf_get_name 0)
                     target (.. (vim.fn.fnamemodify current ":p:r") ".md")
                     cmd [:pandoc current :--from=org :--to=gfm :-o target]
                     on-success (fn [output]
                                  (vim.notify (.. "Wrote to " target)))
                     on-error (fn [err]
                                (vim.notify (.. "Error: " err)))]
                 (exporter cmd target on-success on-error)))}
    :c
    {:label "Export closest headline to clipboard as GitHub flavored markdown"
     :action (fn [exporter]
               (let [org-api (require :orgmode.api)
                     current (org-api.current)
                     headline (current:get_closest_headline)
                     lines (vim.api.nvim_buf_get_lines
                             0
                             (- headline.position.start_line 1)
                             headline.position.end_line
                             false)
                     content (table.concat lines "\n")
                     tmppath (vim.fn.tempname)
                     tmp (io.open tmppath :w)
                     cmd [:pandoc tmppath :--from=org :--to=gfm]
                     on-success (fn [output]
                                  (vim.fn.setreg :+ output)
                                  (vim.notify "Successfully copied into clipboard"))
                     on-error (fn [err]
                                (vim.notify (.. "Error: " err)))]
                 (tmp:write content)
                 (tmp:close)
                 (exporter cmd "" on-success on-error)))}
    :x
    {:label "Export closest headline to clipboard"
     :action (fn [exporter]
               (let [export-type (vim.fn.input "Export type: ")]
                 (when (and export-type (not (= export-type "")))
                   (let [org-api (require :orgmode.api)
                         current (org-api.current)
                         headline (current:get_closest_headline)
                         lines (vim.api.nvim_buf_get_lines
                                 0
                                 (- headline.position.start_line 1)
                                 headline.position.end_line
                                 false)
                         content (table.concat lines "\n")
                         tmppath (vim.fn.tempname)
                         tmp (io.open tmppath :w)
                         cmd [:pandoc tmppath :--from=org (.. :--to= export-type)]
                         on-success (fn [output]
                                      (vim.fn.setreg :+ output)
                                      (vim.notify "Successfully copied into clipboard"))
                         on-error (fn [err]
                                    (vim.notify (.. "Error: " err)))]
                     (tmp:write content)
                     (tmp:close)
                     (exporter cmd "" on-success on-error)))))}}


   :win_split_mode :auto
   :org_highlight_latex_and_related :entities
   :org_hide_emphasis_markers true
   :ui
   {:menu
    {:handler (fn [data]
                (let [m (modern-menu:new
                          {:window
                           {:margin [1 0 1 0]
                            :padding [0 1 0 1]
                            :title_pos :center
                            :border :single
                            :zindex 1000}
                           :icons
                           {:separator "➜"}})]
                  (m:open data)))}}})

(roam.setup
  {:directory (->path :roam)
   :org_files [inbox
               (->path :journal/*.org)]
   :templates
   {:f {:description "󰎚 fleeting"
        :template (->tmplstr :roam/fleeting.org)
        :target "fleeting%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}
    :w {:description "󰖬 wiki"
        :template (->tmplstr :roam/wiki.org)
        :target "wiki%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}
    :p {:description " project"
        :template (->tmplstr :roam/project.org)
        :target "project%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}
    :c {:description " code"
        :template (->tmplstr :roam/code.org)
        :target "code%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}
    :b {:description " book"
        :template (->tmplstr :roam/book.org)
        :target "book%[sep]%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}
    :s {:description " scrap"
        :template (->tmplstr :roam/scrap.org)
        :target "scrap/%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}}})

(bullets.setup
  {:concealcursor false
   :symbols icon.org-bullets})

(fn open-fn [filepath]
  (fn []
     (vim.cmd (.. "e " filepath))))
(let [filepath (->path :inbox.org)]
  (vim.api.nvim_create_user_command :OrgInbox (open-fn filepath) {}))
(let [filepath (->path
                 (.. :journal/ (vim.fn.strftime :%Y-%m (vim.fn.localtime)) :.org))]
  (vim.api.nvim_create_user_command :OrgJournal (open-fn filepath) {}))

(fn fd-fn []
  (let [tb (require :telescope.builtin)]
    (tb.find_files
      {:cwd basepath
       :no_ignore true
       :no_ignore_parent true})))
(vim.api.nvim_create_user_command :OrgFind fd-fn {})

(fn live-grep-fn [path]
  (fn []
    (let [tb (require :telescope.builtin)]
      (tb.live_grep
        {:cwd path
         :type_filter :org}))))
(vim.api.nvim_create_user_command :OrgLiveGrep (live-grep-fn basepath) {})
(vim.api.nvim_create_user_command :RoamLiveGrep (live-grep-fn (->path :roam)) {})

(fn grep-fn [path]
  (fn []
    (let [query (vim.fn.input "Grep: ")
          tb (require :telescope.builtin)]
      (when (and query (not (= query "")))
        (tb.grep_string
          {:prompt_title (.. "Grep for: " query)
           :cwd path
           :use_regex true
           :search (vim.fn.kensaku#query query {:rxop vim.g.kensaku#rxop#javascript})})))))
(vim.api.nvim_create_user_command :OrgGrep (grep-fn basepath) {})
(vim.api.nvim_create_user_command :RoamGrep (grep-fn (->path :roam)) {})

(fn refile-to-today []
  (let [date (os.date "%Y-%m-%d")]
    (vim.cmd (.. "Telescope orgmode refile_heading default_text=" date))))
(vim.api.nvim_create_user_command :OrgRefileToToday refile-to-today {})

(fn roam-pull []
  (Snacks.terminal.open "bb pull" {:cwd (->path :roam)
                                   :interactive false}))
(vim.api.nvim_create_user_command :RoamPull roam-pull {})

(fn roam-commit-push []
  (Snacks.terminal.open "bb push" {:cwd (->path :roam)
                                   :interactive false}))
(vim.api.nvim_create_user_command :RoamCommitPush roam-commit-push {})
