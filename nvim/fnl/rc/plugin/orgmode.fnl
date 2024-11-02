(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local icon (autoload :rc.icon))

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
                      (->path :journal/*.org)]
   :org_default_notes_file inbox
   :org_archive_location (->path "archive/%s_archive::")
   :org_todo_keywords [:TODO
                       :WAITING
                       :IN_REVIEW
                       :|
                       :CANCELED
                       :DONE]
   :org_startup_folded :overview
   :org_capture_templates
   {:t {:description "Add a new task to inbox"
        :template (->tmplstr :task.org)
        :target inbox
        :headline :Tasks}
    :n {:description "Add a new note to inbox"
        :subtemplates
        {:c {:description "code-reading note"
             ;; TODO: add link to github in template
             :template (->tmplstr :code-note.org)
             :target inbox
             :headline :Notes}
         :d {:description "default note"
             :template (->tmplstr :note.org)
             :target inbox
             :headline :Notes}
         :l {:description "with link"
             :template (->tmplstr :link.org)
             :target inbox
             :headline :Notes}
         :p {:description "with clipboard content"
             :template (->tmplstr :paste.org)
             :target inbox
             :headline :Notes}}}
    :j {:description "Add a new note to journal"
        :template (->tmplstr :journal.org)
        :target (->path :journal/%<%Y-%m>.org)
        :datetree {:tree_type :day}}}
   :org_tags_column 90
   :org_custom_exports
   {:g
    {:label "Export to GitHub flavored markdown"
     :action (fn [exporter]
               (let [current (vim.api.nvim_buf_get_name 0)
                     target (.. (vim.fn.fnamemodify current ":p:r") ".md")
                     cmd [:pandoc current :-o target]]
                 (exporter cmd target)))}}
   :win_split_mode :auto
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
               (->path :journal/*.org)]})

(bullets.setup
  {:concealcursor false
   :symbols icon.org-bullets})
