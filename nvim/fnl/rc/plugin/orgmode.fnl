(local {: autoload} (require :nfnl.module))

(local icon (autoload :rc.icon))
(local color (autoload :rc.color))
(local async (autoload :plenary.async))

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
                       :WIP
                       :IN_REVIEW
                       :|
                       :DONE
                       :CANCELED]
   :org_todo_keyword_faces
   {:TODO (.. ":foreground " colors.color5 " :background " colors.color8 " :underline on")
    :WIP (.. ":foreground " colors.color5 " :background " colors.warn)
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
        :datetree {:tree_type :day}}
    :d {:description "󰃭 Add a new daily report to journal"
        :template (->tmplstr :daily-report.org)
        :target (->path :journal/%<%Y-%m>.org)
        :datetree {:tree_type :day}}
    :r {:description "󰍣 Add a new review task to journal"
        :template (->tmplstr :task-review.org)
        :target (->path :journal/%<%Y-%m>.org)
        :datetree {:tree_type :day}}}
   :calendar_week_start_day 0
   :org_deadline_warning_days 7
   :org_tags_column 90
   :org_id_link_to_org_use_id true
   :org_custom_exports
   {:c
    {:label "Export whole document to clipboard"
     :action (fn [exporter]
               (let [export-type (vim.fn.input "Export type: ")]
                 (when (and export-type (not (= export-type "")))
                   (let [lines (vim.api.nvim_buf_get_lines 0 0 -1 false)
                         content (table.concat lines "\n")
                         tmppath (vim.fn.tempname)
                         tmp (io.open tmppath :w)
                         cmd [:pandoc tmppath :--wrap=preserve :--from=org (.. :--to= export-type)]
                         on-success (fn [output]
                                      (vim.fn.setreg :+ output)
                                      (vim.notify "Successfully copied into clipboard"))
                         on-error (fn [err]
                                    (vim.notify (.. "Error: " err)))]
                     (tmp:write content)
                     (tmp:close)
                     (exporter cmd "" on-success on-error)))))}
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
                         cmd [:pandoc tmppath :--wrap=preserve :--from=org (.. :--to= export-type)]
                         on-success (fn [output]
                                      (vim.fn.setreg :+ output)
                                      (vim.notify "Successfully copied into clipboard"))
                         on-error (fn [err]
                                    (vim.notify (.. "Error: " err)))]
                     (tmp:write content)
                     (tmp:close)
                     (exporter cmd "" on-success on-error)))))}
    :d
    {:label "Export to PDF file via pandoc & typst"
     :action (fn [exporter]
               (let [current (vim.api.nvim_buf_get_name 0)
                     target (.. (vim.fn.fnamemodify current ":p:r") ".pdf")
                     template-path (.. (vim.fn.tempname) :.typ)
                     template (io.open template-path :w)
                     cmd [:pandoc current :--from=org :--to=pdf :--pdf-engine=typst (.. :--template= template-path) :-o target]
                     on-success (fn [output]
                                  (vim.notify (.. "Successfully saved to: " target)))
                     on-error (fn [err]
                                (vim.notify (.. "Error: " err)))]
                 (template:write "$body$")
                 (template:close)
                 (exporter cmd target on-success on-error)))}
    :v
    {:label "Export closest headline to PDF file via pandoc & typst"
     :action (fn [exporter]
               (let [org-api (require :orgmode.api)
                     current (org-api.current)
                     target (.. (vim.fn.fnamemodify (vim.api.nvim_buf_get_name 0) ":p:r") ".pdf")
                     headline (current:get_closest_headline)
                     lines (vim.api.nvim_buf_get_lines
                             0
                             (- headline.position.start_line 1)
                             headline.position.end_line
                             false)
                     content (table.concat lines "\n")
                     tmppath (vim.fn.tempname)
                     tmp (io.open tmppath :w)
                     template-path (.. (vim.fn.tempname) :.typ)
                     template (io.open template-path :w)
                     cmd [:pandoc tmppath :--from=org :--to=pdf :--pdf-engine=typst (.. :--template= template-path) :-o target]
                     on-success (fn [output]
                                  (vim.notify (.. "Successfully saved to: " target)))
                     on-error (fn [err]
                                (vim.notify (.. "Error: " err)))]
                 (template:write "$body$")
                 (template:close)
                 (tmp:write content)
                 (tmp:close)
                 (exporter cmd target on-success on-error)))}}
   :win_split_mode :auto
   :org_highlight_latex_and_related :entities
   :org_hide_emphasis_markers true
   :notifications
   {:enabled true
    :cron_enabled false
    :repeater_reminder_time [0 5 10 15]
    :deadline_warning_reminder_time [0 5 10 15]
    :reminder_time [0 5 10 15]
    :notifier (fn [tasks]
                (each [_ task (ipairs tasks)]
                  (let [id (string.format
                             "%s:%s"
                             (task.original_time:to_string)
                             task.title)]
                    (Snacks.notifier
                      (table.concat
                        [(string.format
                           "# %s (%s)"
                           task.category
                           task.humanized_duration)
                         (string.format
                           "%s %s"
                           (string.rep :* task.level)
                           (if task.todo
                               (string.format "%s %s" task.todo task.title)
                               task.title))
                         (string.format
                           "%s: <%s>"
                           task.type
                           (task.time:to_string))] "\n")
                      :info
                      {:id id
                       :timeout false}))))}
   :ui
   {:input {:use_vim_ui true}
    :menu
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
        :target "scrap/%<%Y%m%d%H%M%S>-%[slug]%^{filename suffix?||.local}.org"}}
   :immediate
   {:target "immediate%[sep]%<%Y%m%d%H%M%S>-%[slug].org"
    :template (->tmplstr :roam/immediate.org)}})

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
  (let [snacks (require :snacks)]
    (snacks.picker.files
      {:cwd basepath
       :ignored true})))
(vim.api.nvim_create_user_command :OrgFind fd-fn {})

(fn live-grep-fn [path]
  (fn []
    (let [snacks (require :snacks)]
      (snacks.picker.grep
        {:cwd path
         :ignored true}))))
(vim.api.nvim_create_user_command :OrgGrep (live-grep-fn basepath) {})
(vim.api.nvim_create_user_command :RoamGrep (live-grep-fn (->path :roam)) {})

(fn grep-fn [path]
  (fn []
    (let [snacks (require :snacks)]
      (snacks.picker.kensaku
        {:cwd path}))))
(vim.api.nvim_create_user_command :OrgKensaku (grep-fn basepath) {})
(vim.api.nvim_create_user_command :RoamKensaku (grep-fn (->path :roam)) {})

(fn refile-to-today []
  (let [t (require :telescope)
        date (os.date "%Y-%m-%d %A")]
    (t.extensions.orgmode.refile_heading
      {:default_text date})))
(vim.api.nvim_create_user_command :OrgRefileToToday refile-to-today {})

(fn roam-pull []
  (Snacks.terminal.open "bb pull" {:cwd (->path :roam)
                                   :interactive false}))
(vim.api.nvim_create_user_command :RoamPull roam-pull {})

(fn roam-commit-push []
  (Snacks.terminal.open "bb push" {:cwd (->path :roam)
                                   :interactive false}))
(vim.api.nvim_create_user_command :RoamCommitPush roam-commit-push {})

(fn roam-status []
  (Snacks.terminal.open "bb status" {:cwd (->path :roam)
                                     :interactive false}))
(vim.api.nvim_create_user_command :RoamStatus roam-status {})

(fn build-todays-agenda-helper []
  (let [orgmode (require :orgmode)
        agenda-types (require :orgmode.agenda.types)
        view-opts (vim.tbl_extend :force {} {:files orgmode.agenda.files
                                             :agenda_filter orgmode.agenda.filters
                                             :highlighter orgmode.agenda.highlighter
                                             :span :day})
        view (agenda-types.agenda:new view-opts)
        agenda-day (. (view:_get_agenda_days) 1)]
    {:view view
     :agenda-day agenda-day
     :items agenda-day.agenda_items}))

(fn agenda-ignored? [entry]
  (accumulate [ignored? false
               _ t (ipairs entry.tokens)]
    (or ignored?
        (and (= t.hl_group "@org.agenda.tag")
             (string.match t.content :ignored)))))

(fn build_todays_agenda []
  (let [{: view
         : agenda-day
         : items} (build-todays-agenda-helper)]
    (-> (icollect [_ item (ipairs items)]
         (let [entry (view:_build_line item agenda-day)
               line (entry:compile)]
           (when (and (= entry.metadata.agenda_item.headline_date.type :SCHEDULED)
                      entry.metadata.agenda_item.is_same_day
                      (not (= entry.metadata.agenda_item.label "Scheduled:"))
                      (not (string.match line.content :CANCELED))
                      (not (agenda-ignored? entry)))
             (-> line.content
                 (string.gsub "^(%s+)([^%s]+):(%s+)" "")
                 (string.gsub "Scheduled:%s([%u_]+)%s" "")))))
        (table.concat "\n"))))

(fn build_todays_tasks []
  (let [{: view
         : agenda-day
         : items} (build-todays-agenda-helper)
        add-task-postfix (fn [line]
                           (if (string.match line :WIP)
                             (.. line " (wip)")
                             (if (string.match line :IN_REVIEW)
                               (.. line " (in review)")
                               (if (string.match line :DONE)
                                 (.. line " (done)")
                                 line))))]
    (-> (icollect [_ item (ipairs items)]
         (let [entry (view:_build_line item agenda-day)
               line (entry:compile)]
           (when (and entry.metadata.agenda_item.is_same_day
                      (or (= entry.metadata.agenda_item.headline_date.type :SCHEDULED)
                          (= entry.metadata.agenda_item.headline_date.type :DEADLINE))
                      (or (= entry.metadata.agenda_item.label "Scheduled:")
                          (= entry.metadata.agenda_item.label "Deadline:"))
                      (not (string.match line.content :CANCELED))
                      (not (agenda-ignored? entry)))
             (-> line.content
                 (add-task-postfix)
                 (string.gsub "^(%s+)([^%s]+):(%s+)" "")
                 (string.gsub "Scheduled:(%s+)([%u_]+)%s" "- ")
                 (string.gsub "Deadline:(%s+)([%u_]+)%s" "- ")))))
        (table.concat "\n"))))

(comment
  (build-todays-agenda-helper)
  (build_todays_agenda)
  (build_todays_tasks))

(fn get_agenda [span year month day]
  (let [orgmode (require :orgmode)
        agenda-types (require :orgmode.agenda.types)
        date (require :orgmode.objects.date)
        from (if (and year month day)
                 (date.from_string (vim.fn.printf "%04d-%02d-%02d" year month day))
                 nil)
        view-opts (vim.tbl_extend :force {} {:files orgmode.agenda.files
                                             :agenda_filter orgmode.agenda.filters
                                             :highlighter orgmode.agenda.highlighter
                                             :span span
                                             :from from})
        view (agenda-types.agenda:new view-opts)]
    (-> (icollect [_ agenda-day (ipairs (view:_get_agenda_days))]
          (let [agenda (-> (icollect [_ item (ipairs agenda-day.agenda_items)]
                            (let [entry (view:_build_line item agenda-day)
                                  line (entry:compile)]
                              line.content)))]
            {:year agenda-day.day.year
             :month agenda-day.day.month
             :day agenda-day.day.day
             :agenda agenda})))))

(fn get_all_roam_nodes []
  (let [roam (require :org-roam)
        ids (roam.database:ids)]
    (icollect [_ id (ipairs ids)]
      (let [node (roam.database:get_sync id)]
        {:id id
         :title node.title
         :aliases node.aliases}))))

(fn get_roam_node_by_id [id]
  (let [roam (require :org-roam)]
    (roam.database:get_sync id)))

(fn create_roam_node [title body cb]
  (let [roam (require :org-roam)
        promise (roam.api.capture_node
                  {:immediate true
                   :origin false
                   :title title})]
    (promise:next
      (fn [id]
        (let [node (get_roam_node_by_id id)]
          (-> body
              (vim.fn.split "\n")
              (vim.fn.writefile node.file :a))
          (cb id))))))

(fn roam-refresh-search-index []
  (vim.notify "start roam refresh search index" :info)
  (let [started-time (os.time)
        async-system (async.wrap vim.system 3)
        nodes->info (fn [nodes]
                      (local tbl [])
                      (icollect [_ node (ipairs nodes)]
                        (let [info (get_roam_node_by_id node.id)]
                          (table.insert tbl {:node-id node.id
                                             :path info.file})))
                      tbl)
        nodes (-> (get_all_roam_nodes)
                  (nodes->info)
                  (vim.json.encode))
        index (fn [nodes]
                (when (> (length nodes) 0)
                  (let [job (async-system
                              [:org-search-utils-index]
                              {:stdin nodes
                               :text true})]
                    (if (= job.code 0)
                      (values true "success!")
                      (values false job.stderr)))))]
    (async.run
      (fn []
        (let [(ok? err) (index nodes)]
          (async.util.scheduler)
          (if ok?
            (let [current-time (os.time)
                  took (- current-time started-time)]
              (vim.notify (.. "refresh vector index: took " took :s) :info))
            (vim.notify (.. "Error on refresh search index: " err)))))
      nil
      (fn [err]
        (async.util.scheduler)
        (vim.notify (.. "Error on refresh search index: " (tostring err)))))))
(vim.api.nvim_create_user_command :RoamRefreshSearchIndex roam-refresh-search-index {})

(fn query_roam_fragments [query limit cb errcb]
  (let [async-system (async.wrap vim.system 3)
        ->search (fn [query]
                   (when query
                     (let [job (async-system
                                 [:org-search-utils-search query limit]
                                 {:text true})]
                       (if (= job.code 0)
                         (let [results (vim.json.decode job.stdout)]
                           (if (and results (> (length results) 0))
                             (values true (vim.json.encode results))
                             (values false "No results found")))
                         (values false job.stderr)))))]
    (async.run
      (fn []
        (let [(ok? result) (->search query limit)]
          (async.util.scheduler)
          (if ok?
            (cb result)
            (errcb result))))
      nil
      (fn [err]
        (async.util.scheduler)
        (errcb (.. "Error: " (tostring err)))))))

(fn query_roam_headings [query limit cb errcb]
  (let [async-system (async.wrap vim.system 3)
        ->search (fn [query]
                   (when query
                     (let [job (async-system
                                 [:org-search-utils-search :--title_only query limit]
                                 {:text true})]
                       (if (= job.code 0)
                         (let [results (vim.json.decode job.stdout)]
                           (if (and results (> (length results) 0))
                             (values true (vim.json.encode results))
                             (values false "No results found")))
                         (values false job.stderr)))))]
    (async.run
      (fn []
        (let [(ok? result) (->search query limit)]
          (async.util.scheduler)
          (if ok?
            (cb result)
            (errcb result))))
      nil
      (fn [err]
        (async.util.scheduler)
        (errcb (.. "Error: " (tostring err)))))))

(comment
  (roam-refresh-search-index)
  (query_roam_fragments :Neovim 10 print print)
  (-> (icollect [_ node (ipairs (get_all_roam_nodes))]
        (let [n (get_roam_node_by_id node.id)]
          {:node-id node.id
           :path n.file}))
      (vim.json.encode)))

(fn get_roam_node_links [id]
  (let [roam (require :org-roam)
        node (roam.database:get_sync id)]
    (roam.database:get_file_links_sync node.file)))

(fn get_roam_node_backlinks [id]
  (let [roam (require :org-roam)
        node (roam.database:get_sync id)]
    (roam.database:get_file_backlinks_sync node.file)))

(fn get_roam_heading_content [id title]
  (let [org-api (require :orgmode.api)
        node (get_roam_node_by_id id)
        org-file (org-api.load node.file)]
    (icollect [_ headline (ipairs org-file.headlines)]
      (when (= headline.title title)
        (let [lines (icollect [i l (ipairs org-file._file.lines)]
                      (when (and (<= headline.position.start_line i)
                                 (>= headline.position.end_line i))
                        l))
              children (icollect [_ child (ipairs headline.headlines)]
                         {:title child.title
                          :level child.level})]
          {:node {:id node.id
                  :title node.title}
           :file node.file
           :title title
           :level headline.level
           :lines lines
           :children children
           :position {:start_line headline.position.start_line
                      :end_line headline.position.end_line}})))))

{: build_todays_agenda
 : build_todays_tasks
 : get_agenda
 : get_all_roam_nodes
 : get_roam_node_by_id
 : create_roam_node
 : query_roam_fragments
 : query_roam_headings
 : get_roam_node_links
 : get_roam_node_backlinks
 : get_roam_heading_content}
