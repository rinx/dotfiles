(ns items.battery
  (:require
   [colors]
   [common]
   [fonts]
   [sketchybar]))

(defn setup []
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
   (sketchybar/subscribe :battery :power_source_change :system_woke)))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
