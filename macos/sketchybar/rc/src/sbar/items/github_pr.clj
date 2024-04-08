(ns sbar.items.github-pr
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
   (sketchybar/add-item :github.pr :right)
   (sketchybar/set
    :github.pr
    {:click_script "sketchybar --set $NAME popup.drawing=toggle"
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :github :pullreq)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn prs []
  (-> (common/sh "gh" "search" "prs" "--state=open" "--review-requested=@me" "--json=repository,url,title")
      (json/parse-string csk/->kebab-case-keyword)))

(defn ->element [idx {:keys [repository title url]}]
  (let [item (str "github.prlist." idx)
        add-args (sketchybar/add-item item :popup.github.pr)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (str
                          (icons/get :github :pullreq)
                          \space
                          (:name-with-owner repository))
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label title
                   :click_script
                   (str/join
                    "\n"
                    [(str "open " url)
                     "sketchybar --set github.pr popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn update []
  (let [prs (prs)]
    (sketchybar/exec
     ["--remove" "/github.prlist\\.*/"]
     (sketchybar/set :github.pr {:label (count prs)})
     (map-indexed ->element prs))))
