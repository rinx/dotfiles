(ns plugins.volume
  (:require
   [clojure.string :as str]
   [sketchybar]
   [common]
   [icons]))

(defn mute? []
  (-> (common/sh "osascript" "-e" "output muted of (get volume settings)")
      (str/trim-newline)
      (= "true")))

(defn get-volume []
  (-> (common/sh "osascript" "-e" "output volume of (get volume settings)")
      (str/trim-newline)
      (Integer/parseInt)))

(defn toggle-mute []
  (if (mute?)
    (common/sh "osascript" "-e" (str "set volume without output muted"))
    (common/sh "osascript" "-e" (str "set volume with output muted"))))

(defn update-indicator []
  (let [item (System/getenv "NAME")]
    (sketchybar/exec
     (sketchybar/set
      item
      (if (mute?)
        {:icon (icons/get :volume :mute)
         :label "MUTE"}
        {:icon (icons/get :volume :unmute)
         :label (str (get-volume) "%")})))))

(defn -main [& args]
  (when (= (System/getenv "SENDER") "mouse.clicked")
    (toggle-mute))
  (update-indicator))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
