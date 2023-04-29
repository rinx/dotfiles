(ns plugins.front-app
  (:require
   [colors]
   [common]
   [icons]
   [sketchybar]))

(defn -main [& args]
  (when (= (System/getenv "SENDER") "front_app_switched")
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      {:label (System/getenv "INFO")}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
