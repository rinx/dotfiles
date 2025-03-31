(ns sbar.plugins.spaces
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sketchybar.core :as sketchybar]))

(defn -main [& args]
  (let [item-name (System/getenv "NAME")
        focused-idx (str/trim (System/getenv "FOCUSED_WORKSPACE"))
        idx (str/trim (re-find #"\d+" item-name))
        focused? (= idx focused-idx)]
    (sketchybar/exec
     (sketchybar/set
      item-name
      {:background.border_color (colors/get (if focused?
                                              :cyan
                                              :transparent-black))}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
