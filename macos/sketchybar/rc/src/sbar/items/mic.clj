(ns sbar.items.mic
  (:require
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.colors :as colors]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :mic :right)
   (sketchybar/set
    :mic
    {:script (common/plugin-script "mic.jar")
     :update_freq 20
     :icon.font (fonts/get :Medium 12.0)
     :icon.color (colors/get :blue)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :mic :mouse.clicked)))
