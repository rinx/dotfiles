(ns sbar.items.mic
  (:require
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :mic :right)
   (sketchybar/set
    :mic
    {:script (common/plugin-script "mic.jar")
     :update_freq 20
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :mic :mouse.clicked)))
