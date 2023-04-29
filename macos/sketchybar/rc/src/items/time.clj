(ns items.time
  (:require
   [colors]
   [common]
   [fonts]
   [sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :time :right)
   (sketchybar/set
    :time
    {:script (common/plugin-script "time.jar")
     :update_freq 2
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.padding_right 0
     :label.padding_left 0
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
