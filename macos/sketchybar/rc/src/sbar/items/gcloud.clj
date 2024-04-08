(ns sbar.items.gcloud
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :gcloud.current :right)
   (sketchybar/set
    :gcloud.current
    {:click_script "sketchybar --set $NAME popup.drawing=toggle"
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :gcloud)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn contexts []
  (->> (common/sh "gcloud" "config" "configurations" "list" "--format" "value(name)")
       (str/split-lines)))

(defn current-context []
  (->> (common/sh "gcloud" "info" "--format" "get(config.active_config_name)")
       (str/trim-newline)))

(defn ->element [idx ctx]
  (let [item (str "gcloud.list." idx)
        add-args (sketchybar/add-item item :popup.gcloud.current)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (icons/get :gcloud)
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label ctx
                   :click_script
                   (str/join
                    "\n"
                    [(str "gcloud config configurations activate " ctx)
                     (str "sketchybar --set gcloud.current label=" ctx)
                     "sketchybar --set gcloud.current popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn update []
  (sketchybar/exec
   ["--remove" "/gcloud.list\\.*/"]
   (sketchybar/set :gcloud.current {:label (current-context)})
   (map-indexed ->element (contexts))))
