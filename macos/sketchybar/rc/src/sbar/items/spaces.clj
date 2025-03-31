(ns sbar.items.spaces
  (:require
   [clojure.string :as str]
   [sbar.common :as common]
   [sbar.colors :as colors]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn get-space-numbers []
  (-> (common/sh "aerospace" "list-workspaces" "--all")
      (str/split #"\n")))

(defn space [idx]
  (let [item (str "space." idx)]
    (flatten
     [(sketchybar/add-item item :left)
      (sketchybar/subscribe item :aerospace_workspace_change)
      (sketchybar/set
        item
        {:background.corner_radius 4
         :background.color (colors/get :transparent-black)
         :background.border_color (colors/get :transparent-black)
         :icon.padding_left 10
         :icon.padding_right 0
         :label.padding_left 0
         :label.padding_right 10
         :label.font (fonts/get :Regular 12.0)
         :label.color (colors/get :cream)
         :icon.font (fonts/get :Medium 16.0)
         :icon (nth icons/spaces (dec (Integer/parseInt idx)))
         :script (common/plugin-script "spaces.jar")})])))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-event :aerospace_workspace_change))
  (apply sketchybar/exec (->> (get-space-numbers)
                              (map space))))
