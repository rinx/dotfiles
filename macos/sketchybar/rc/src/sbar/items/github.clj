(ns sbar.items.github
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :github.notification :right)
   (sketchybar/set
    :github.notification
    {:click_script "sketchybar --set $NAME popup.drawing=toggle"
     :icon (icons/get :github :octocat)
     :icon.font (fonts/get :Medium 16.0)
     :icon.color (colors/get :light-green)
     :label "-"
     :label.font (fonts/get :Medium 12.0)})))

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

(defn update []
  (let [notifications (notifications)
        cnt (count notifications)]
    (sketchybar/exec
     ["--remove" "/github.notification.list\\.*/"]
     (sketchybar/set :github.notification {:drawing (if (zero? cnt) :off :on)
                                           :label cnt})
     (map-indexed ->element notifications))))
