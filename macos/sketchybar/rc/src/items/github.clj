(ns items.github
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :github.notification :right)
   (sketchybar/set
    :github.notification
    {:script (common/plugin-script "github.jar")
     :click_script "sketchybar --set $NAME popup.drawing=toggle"
     :update_freq 180
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :github :octocat)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 16.0)
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
