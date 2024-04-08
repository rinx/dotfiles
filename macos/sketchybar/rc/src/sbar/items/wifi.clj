(ns sbar.items.wifi
  (:require
   [clojure.string :as str]
   [clojure.walk :as walk]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :wifi :right)
   (sketchybar/set
    :wifi
    {:background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :wifi :wifi_change)))

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

(defn update []
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
      :wifi
      {:icon icon
       :label label}))))
