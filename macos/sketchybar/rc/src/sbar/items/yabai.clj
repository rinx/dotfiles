(ns sbar.items.yabai
  (:require
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-event :window_focus)
   (sketchybar/add-item :system.yabai :left)
   (sketchybar/set
    :system.yabai
    {:script (common/plugin-script "yabai.jar")
     :associated_display :active
     :updates :on
     :icon (icons/get :yabai :grid)
     :icon.color (colors/get :light-green)
     :icon.font (fonts/get :Bold 14.0)
     :icon.width 30
     :icon.padding_left 10
     :label.drawing :off})
   (sketchybar/subscribe :system.yabai :window_focus :mouse.clicked)))
