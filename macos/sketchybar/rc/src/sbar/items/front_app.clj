(ns sbar.items.front-app
  (:require
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :front_app :left)
   (sketchybar/set
    :front_app
    {:script (common/plugin-script "front_app.jar")
     :associated_display :active
     :icon.color (colors/get :cream)
     :icon.font (fonts/get fonts/app-font :Regular 16.0)
     :label.color (colors/get :cream)
     :label.font (fonts/get "Bold Italic" 14.0)
     :background.padding_left 10
     :background.padding_right 10})
   (sketchybar/subscribe :front_app :front_app_switched)))
