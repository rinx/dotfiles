(ns plugins.github
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [clojure.string :as str]
   [colors]
   [common]
   [icons]
   [sketchybar]))

(defn gh-api [endpoint]
  (-> (common/sh "gh" "api" endpoint)
      (json/parse-string csk/->kebab-case-keyword)))

(defn notifications []
  (gh-api "notifications"))

(defn subject-url->html-url [subject-url]
  (when-let [response (gh-api subject-url)]
    (get-in response [:html-url])))

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
        url (or (subject-url->html-url (get-in notification [:subject :url]))
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
