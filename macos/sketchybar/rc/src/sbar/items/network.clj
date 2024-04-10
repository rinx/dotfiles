(ns sbar.items.network
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :network.up :right)
   (sketchybar/set
    :network.up
    {:label.font (fonts/get :SemiBold 8.0)
     :label "0.0KB/s"
     :icon.font (fonts/get :SemiBold 7.0)
     :icon (icons/get :net :upload)
     :width 0
     :y_offset 5})
   (sketchybar/add-item :network.down :right)
   (sketchybar/set
    :network.down
    {:label.font (fonts/get :SemiBold 8.0)
     :label "0.0KB/s"
     :icon.font (fonts/get :SemiBold 7.0)
     :icon (icons/get :net :download)
     :width 0
     :y_offset -5})))

(defn ifstat-updown []
  (-> (common/sh "ifstat" "-i" "en0" "-b" "0.1" "1")
      (str/split-lines)
      (last)
      (str/split #" ")
      (->> (filter not-empty)
           (map (fn [x]
                  (/ (Float/parseFloat x) 8)))
           (zipmap [:down :up]))))

(defn ->fmt [v]
  (if (> v 999)
    (format "%.1fMB/s" (/ v 1000))
    (format "%.1fKB/s" v)))

(defn update []
  (let [{:keys [up down]} (ifstat-updown)]
    (sketchybar/exec
     (sketchybar/set
      :network.up
      {:label (->fmt up)})
     (sketchybar/set
      :network.down
      {:label (->fmt down)}))))
