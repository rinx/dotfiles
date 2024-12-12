(ns sbar.plugins.spaces
  (:require
   [sbar.colors :as colors]
   [sketchybar.core :as sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/set
    (System/getenv "NAME")
    (into {:background.color (colors/get :transparent-black)
           :background.border_color (colors/get :transparent-black)
           :background.padding_left 3
           :background.padding_right 3
           :label.color (colors/get :cream)
           :label (System/getenv "FOCUSED_WORKSPACE")}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
