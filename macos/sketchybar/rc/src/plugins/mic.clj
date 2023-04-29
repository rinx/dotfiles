(ns plugins.mic
  (:require
   [clojure.string :as str]
   [common]
   [icons]
   [sketchybar]))

(defn get-mic-volume []
  (-> (common/sh "osascript" "-e" "input volume of (get volume settings)")
      (str/trim-newline)
      (Integer/parseInt)))

(defn update-mic-volume [volume]
  (common/sh "osascript" "-e" (str "set volume input volume " volume)))

(defn update-indicator []
  (let [vol (get-mic-volume)
        item (System/getenv "NAME")]
    (sketchybar/exec
     (sketchybar/set
      item
      (if (zero? vol)
        {:icon (icons/get :mic :mute)
         :label "MUTE"}
        {:icon (icons/get :mic :unmute)
         :label (str vol "%")})))))

(defn toggle-mute []
  (let [vol (get-mic-volume)]
    (update-mic-volume
     (if (zero? vol)
       60
       0))))

(defn -main [& args]
  (when (= (System/getenv "SENDER") "mouse.clicked")
    (toggle-mute))
  (update-indicator))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
