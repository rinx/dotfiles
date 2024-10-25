(local orgmode (require :orgmode))
(local bullets (require :org-bullets))
(local modern-menu (require :org-modern.menu))

(let [basepath "~/notes/org"
      ->path (fn [path]
                 (.. basepath :/ path))]
  (orgmode.setup
    {:org_agenda_files (->path :agenda/**/*)
     :org_default_notes_file (->path :refile.org)
     :org_archive_location (->path "archive/%s_archive::")
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
                    (m:open data)))}}}))

(bullets.setup
  {:concealcursor false
   :symbols
   {:list "•"
    :headlines ["◉" "○" "✸" "✿"]}})
