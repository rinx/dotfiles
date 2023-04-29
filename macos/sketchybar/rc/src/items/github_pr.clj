(ns items.github-pr
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :github.pr :right)
   (sketchybar/set
    :github.pr
    {:script (common/plugin-script "github_pr.jar")
     :click_script "sketchybar --set $NAME popup.drawing=toggle"
     :update_freq 180
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :github :pullreq)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
