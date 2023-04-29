(ns plugins.wifi
  (:require
   [clojure.string :as str]
   [clojure.walk :as walk]
   [common]
   [icons]
   [sketchybar]))

(defn airport []
  (->> (common/sh
        "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
        "-I")
       (str/split-lines)
       (mapv (fn [l]
               (-> l
                   (str/trim)
                   (str/split #": "))))
       (filter (fn [x]
                 (= (count x) 2)))
       (into {})
       (walk/keywordize-keys)))

(defn wifi-off? [airport]
  (= (:AirPort airport) "Off"))

(defn ssid [airport]
  (:SSID airport))

(defn -main [& args]
  (let [info (airport)
        off? (wifi-off? info)
        ssid (ssid info)
        icon (cond
               off? (icons/get :wifi :off)
               (nil? ssid) (icons/get :wifi :disconnected)
               :else (icons/get :wifi :connected))
        label (cond
                off? "OFF"
                (nil? ssid) "DISCONNECTED"
                :else ssid)]
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      {:icon icon
       :label label}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
