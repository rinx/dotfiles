(ns sbar.items.battery
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :battery :right)
   (sketchybar/set
    :battery
    {:background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 14.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :battery :power_source_change :system_woke)))

(defn- ->icon [percentage charging]
  (->> (if charging
         :charging
         (condp < percentage
           85 :100
           60 :75
           30 :50
           10 :25
           :0))
       (icons/get :battery)))

(defn update []
  (let [info (common/sh "pmset" "-g" "batt")
        percentage (-> info
                       (->> (re-matcher #"\d+%")
                            (re-find))
                       (str/replace "%" "")
                       (Integer/parseInt))
        charging (-> info
                     (->> (re-matcher #"AC Power")
                          (re-find))
                     (some?))]
    (if (nil? percentage)
      nil
      (let [icon (->icon percentage charging)]
        (sketchybar/exec
         (sketchybar/set :battery {:label (str percentage "%")
                                   :icon icon}))))))
