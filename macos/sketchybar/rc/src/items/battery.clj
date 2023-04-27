(ns items.battery
  (:require
   [sketchybar]
   [common]
   [colors]
   [fonts]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :battery :right)
   (sketchybar/set
    :battery
    {:script (common/plugin-script "battery.jar")
     :update_freq 5
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 14.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :battery :system_woke)))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
