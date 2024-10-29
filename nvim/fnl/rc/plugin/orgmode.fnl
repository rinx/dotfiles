(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local orgmode (require :orgmode))
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
                       :|
                       :CANCELED
                       :DONE]
   :org_startup_folded :showeverything
   :org_capture_templates
   {:t {:description "Add a new task to inbox"
        :template (->tmplstr :task.org)
        :headline :Tasks}
    :c {:description "Add a code-reading note to inbox"
        ;; TODO: add link to github in template
        :template (->tmplstr :code-snippet.org)
        :headline :Notes}
    :n {:description "Add a new note to inbox"
        :template (->tmplstr :note.org)
        :headline :Notes}
    :j {:description "Add a new note to journal"
        :template (->tmplstr :journal.org)
        :target (->path :journal/%<%Y-%m>.org)
        :datetree {:tree_type :month}}}
   :org_tags_column 90
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

(bullets.setup
  {:concealcursor false
   :symbols
   {:list "•"
    :headlines ["◉" "○" "✸" "✿"]}})
