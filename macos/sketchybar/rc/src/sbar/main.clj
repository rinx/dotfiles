(ns sbar.main
  (:require
   [sbar.colors :as colors]
   [sbar.fonts :as fonts]
   [sbar.items.battery :as battery]
   [sbar.items.brew :as brew]
   [sbar.items.date :as date]
   [sbar.items.front-app :as front-app]
   [sbar.items.gcloud :as gcloud]
   [sbar.items.github :as github]
   [sbar.items.github-pr :as github-pr]
   [sbar.items.kubectx :as kubectx]
   [sbar.items.mic :as mic]
   [sbar.items.spaces :as spaces]
   [sbar.items.time :as time]
   [sbar.items.volume :as volume]
   [sbar.items.weather :as weather]
   [sbar.items.wifi :as wifi]
   [sbar.items.yabai :as yabai]
   [sketchybar.core :as sketchybar]
   [sketchybar.extra :refer [event-loop]]))

(defn init []
  (sketchybar/exec
   (sketchybar/bar
    {:blur_radius 0
     :color colors/bar
     :corner_radius 0
     :height 34
     :margin 0
     :notch_width 188
     :padding_left 12
     :padding_right 12
     :position :top
     :shadow :off
     :sticky :on
     :y_offset 0})
   (sketchybar/default
    {:background.padding_left 3
     :background.padding_right 3
     :background.color colors/background
     :background.height 25
     :background.corner_radius 3
     :background.border_width 1
     :icon.color colors/icon
     :icon.font (fonts/get :Bold 14.0)
     :icon.padding_left 10
     :icon.padding_right 3
     :label.color colors/label
     :label.font (fonts/get :SemiBold 13.0)
     :label.padding_left 3
     :label.padding_right 10
     :popup.background.border_color colors/popup-border
     :popup.background.border_width 1
     :popup.background.color colors/popup-background
     :popup.background.corner_radius 5
     :popup.background.shadow.drawing :off
     :updates :when_shown})))

(defn left-items []
  (spaces/setup)
  ; (yabai/setup)
  (front-app/setup))

(defn center-items [])

(defn right-items []
  (time/setup)
  ; (date/setup)
  ; (weather/setup)
  (battery/setup)
  (mic/setup)
  (volume/setup)
  ; (wifi/setup)
  (kubectx/setup)
  (gcloud/setup)
  (github-pr/setup)
  (github/setup)
  (brew/setup))
  ; (network/setup))

(defn -main [& args]
  (init)

  (left-items)
  (center-items)
  (right-items)

  (sketchybar/update)

  (event-loop
   {:battery {:fn battery/update
              :duration-ms 60000}
    :brew {:fn brew/update
           :duration-ms 7200000}
    :date {:fn date/update
           :duration-ms 60000}
    :gcloud {:fn gcloud/update
             :duration-ms 60000}
    :github {:fn github/update
             :duration-ms 180000}
    :github-pr {:fn github-pr/update
                :duration-ms 180000}
    :kubectx {:fn kubectx/update
              :duration-ms 60000}
    :time {:fn time/update
           :duration-ms 5000}
    :weather {:fn weather/update
              :duration-ms 3600000}
    :wifi {:fn wifi/update
           :duration-ms 60000}}))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
