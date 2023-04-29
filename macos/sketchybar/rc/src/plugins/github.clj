(ns plugins.github
  (:require
   [clojure.string :as str]
   [cheshire.core :as json]
   [camel-snake-kebab.core :as csk]
   [sketchybar]
   [common]
   [colors]
   [icons]))

(defn notifications []
  (-> (common/sh "gh" "api" "notifications")
      (json/parse-string csk/->kebab-case-keyword)))

(defn ->element [idx notification]
  (let [item (str "github.notification.list." idx)
        subject-type (get-in notification [:subject :type])
        title (get-in notification [:subject :title])
        repo (get-in notification [:repository :full_name])
        icon (case subject-type
               "Issue" (icons/get :github :issue)
               "Discussion" (icons/get :github :discussion)
               "CheckSuite" (icons/get :github :check)
               "PullRequest" (icons/get :github :pullreq)
               (icons/get :info))
        icon-color (case subject-type
                     "Issue" (colors/get :light-green)
                     "CheckSuite" (colors/get :light-red)
                     "PullRequest" (colors/get :light-violet)
                     (colors/get :light-grey))
        url (or (get-in notifications [:subject :url])
                "https://github.com/notifications")
        add-args (sketchybar/add-item item :popup.github.notification)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (str icon \space repo)
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color icon-color
                   :label title
                   :click_script
                   (str/join
                    "\n"
                    [(str "open " url)
                     "sketchybar --set github.notification popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn -main [& args]
  (let [notifications (notifications)]
    (sketchybar/exec
     ["--remove" "/github.notification.list\\.*/"]
     (sketchybar/set (System/getenv "NAME") {:label (count notifications)})
     (map-indexed ->element notifications))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
