(ns items.brew
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :brew.outdated :right)
   (sketchybar/set
    :brew.outdated
    {:script (common/plugin-script "brew.jar")
     :click_script "sketchybar --set $NAME popup.drawing=toggle"
     :drawing :off
     :update_freq 43200
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :beer)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 16.0)
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
