(ns sbar.plugins.front-app
  (:require
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn -main [& args]
  (when (= (System/getenv "SENDER") "front_app_switched")
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      (let [app-name (System/getenv "INFO")]
        {:icon (icons/app-font app-name)
         :label app-name})))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
