(ns items.gcloud
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :gcloud.current :right)
   (sketchybar/set
    :gcloud.current
    {:script (common/plugin-script "gcloud.jar")
     :click_script "sketchybar --set $NAME popup.drawing=toggle"
     :update_freq 60
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :gcloud)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
