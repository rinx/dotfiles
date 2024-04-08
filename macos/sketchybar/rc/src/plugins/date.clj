(ns plugins.date
  (:require
   [sketchybar.core :as sketchybar]
   [tick.core :as tick]))

(defn -main [& args]
  (let [date (tick/format (tick/formatter "EEE dd. MMM") (tick/date))]
    (sketchybar/exec
     (sketchybar/set (System/getenv "NAME") {:label date}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
