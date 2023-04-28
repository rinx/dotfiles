(ns items.gcloud
  (:require
   [sketchybar]
   [common]
   [colors]
   [icons]
   [fonts]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :gcloud.current :right)
   (sketchybar/set
    :gcloud.current
    {:script (common/plugin-script "gcloud.jar")
     :click_script "sketchybar --set $NAME popup.drawing=toggle"
     :update_freq 10
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :gcloud)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
