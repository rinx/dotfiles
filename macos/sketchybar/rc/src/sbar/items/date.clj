(ns sbar.items.date
  (:require
   [tick.core :as tick]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :date :right)
   (sketchybar/set
    :date
    {:update_freq 60
     :icon.padding_right 0
     :label.padding_left 0
     :label.font (fonts/get :Medium 12.0)})))

(defn update []
  (let [date (tick/format (tick/formatter "EEE dd. MMM") (tick/date))]
    (sketchybar/exec
     (sketchybar/set :date {:label date}))))
