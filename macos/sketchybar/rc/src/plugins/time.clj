(ns plugins.time
  (:require
   [tick.core :as tick]
   [sketchybar]))

(defn -main [& args]
  (let [time (tick/format (tick/formatter "HH:mm") (tick/time))]
    (sketchybar/exec
     (sketchybar/set (System/getenv "NAME") {:label time}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
