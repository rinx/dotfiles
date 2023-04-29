(ns items.front-app
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :front_app :left)
   (sketchybar/set
    :front_app
    {:script (common/plugin-script "front_app.jar")
     :associated_display :active
     :icon.drawing :off
     :label.color (colors/get :cream)
     :label.font (fonts/get :Bold 14.0)
     :background.padding_left 0
     :background.padding_right 10})
   (sketchybar/subscribe :front_app :front_app_switched)))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
