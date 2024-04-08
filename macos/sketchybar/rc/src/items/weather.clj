(ns items.weather
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :weather :right)
   (sketchybar/set
    :weather
    {:script (common/plugin-script "weather.jar")
     :update_freq 3600
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon "-"
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 14.0)
     :label.y_offset 1
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
