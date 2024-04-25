(ns sbar.items.time
  (:require
   [tick.core :as tick]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sbar.colors :as colors]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :time :right)
   (sketchybar/set
    :time
    {:icon.padding_right 3
     :icon.color (colors/get :red)
     :label.padding_left 0
     :label.font (fonts/get :Medium 12.0)})))

(defn ->icon [t]
  (get icons/clocks
       (rem (dec (+ 12 (tick/hour t))) 12)))

(defn ->label [t]
  (tick/format (tick/formatter "HH:mm") t))

(defn update []
  (let [t (tick/time)
        icon (->icon t)
        label (->label t)]
    (sketchybar/exec
     (sketchybar/set :time {:icon icon
                            :label label}))))
