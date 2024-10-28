(local orgmode (require :orgmode))
(local bullets (require :org-bullets))
(local modern-menu (require :org-modern.menu))

(local basepath "~/notes/org")

(fn ->path [path]
  (.. basepath :/ path))

;; TODO: create ~/notes/org/inbox.org if not exists

(orgmode.setup
  {:org_agenda_files (->path :agenda/**/*)
   :org_default_notes_file (->path :inbox.org)
   :org_archive_location (->path "archive/%s_archive::")
   :org_todo_keywords [:TODO
                       :WAITING
                       :|
                       :CANCELED
                       :DONE]
   :org_startup_folded :showeverything
   :org_capture_templates
   {:t {:description "Add a new task to inbox"
        ;; TODO: load templates from individual file
        :template "** TODO %?\n %U"
        :headline :Tasks}
    :c {:description "Add a code-reading note to inbox"
        ;; TODO: add link to github in template
        :template "** %?\n %a %U"
        :headline :Codes}
    :j {:description "Add a new event or thoughts to journal"
        :template "\n* %<%Y-%m-%d> %<%A>\n** %U\n\n%?"
        :target (->path :journal/%<%Y-%m>.org)}}
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
