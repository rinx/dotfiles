(ns items.date
  (:require
   [colors]
   [common]
   [fonts]
   [sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :date :right)
   (sketchybar/set
    :date
    {:script (common/plugin-script "date.jar")
     :update_freq 60
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.padding_right 0
     :label.padding_left 0
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
