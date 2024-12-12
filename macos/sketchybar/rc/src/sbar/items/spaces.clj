(ns sbar.items.spaces
  (:require
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-event :aerospace_workspace_change))
  (sketchybar/exec
   (sketchybar/add-item :space :left)
   (sketchybar/subscribe :space :aerospace_workspace_change)
   (sketchybar/set
    :space
    {:background.corner_radius 4
     :icon.padding_left 10
     :icon.padding_right 3
     :label.padding_left 3
     :label.padding_right 10
     :label.font (fonts/get :Regular 12.0)
     :icon.font (fonts/get :Medium 16.0)
     :icon (icons/get :space)
     :label "1"
     :script (common/plugin-script "spaces.jar")})))
