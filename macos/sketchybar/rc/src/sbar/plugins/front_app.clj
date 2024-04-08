(ns sbar.plugins.front-app
  (:require
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn -main [& args]
  (when (= (System/getenv "SENDER") "front_app_switched")
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      {:label (System/getenv "INFO")}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))