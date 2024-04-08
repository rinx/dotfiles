(ns sbar.items.time
  (:require
   [tick.core :as tick]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :time :right)
   (sketchybar/set
    :time
    {:background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.padding_right 0
     :label.padding_left 0
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn update []
  (let [time (tick/format (tick/formatter "HH:mm") (tick/time))]
    (sketchybar/exec
     (sketchybar/set :time {:label time}))))
