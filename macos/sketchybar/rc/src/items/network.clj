(ns items.network
  (:require
   [colors]
   [common]
   [fonts]
   [sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :network :right)
   (sketchybar/set
    :network
    {:script (common/plugin-script "network.jar")
     :update_freq 2
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
