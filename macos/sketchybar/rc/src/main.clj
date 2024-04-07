(ns main
  (:require
   [colors]
   [fonts]
   [items.battery :as battery]
   [items.brew :as brew]
   [items.date :as date]
   [items.front-app :as front-app]
   [items.gcloud :as gcloud]
   [items.github :as github]
   [items.github-pr :as pr]
   [items.kubectx :as kubectx]
   [items.mic :as mic]
   [items.spaces :as spaces]
   [items.time :as time]
   [items.volume :as volume]
   [items.weather :as weather]
   [items.wifi :as wifi]
   [items.yabai :as yabai]
   [sketchybar]))

(defn init []
  (sketchybar/exec
   (sketchybar/bar
    {:blur_radius 0
     :color colors/bar
     :corner_radius 5
     :height 28
     :margin 14
     :notch_width 0
     :padding_left 21
     :padding_right 21
     :position :top
     :shadow :off
     :sticky :on
     :y_offset 5})
   (sketchybar/default
    {:background.padding_left 3
     :background.padding_right 3
     :icon.color colors/icon
     :icon.font (fonts/get :Bold 14.0)
     :icon.padding_left 3
     :icon.padding_right 3
     :label.color colors/label
     :label.font (fonts/get :SemiBold 13.0)
     :label.padding_left 3
     :label.padding_right 3
     :popup.background.border_color colors/popup-border
     :popup.background.border_width 1
     :popup.background.color colors/popup-background
     :popup.background.corner_radius 5
     :popup.background.shadow.drawing :off
     :updates :when_shown})))

(defn left-items []
  (spaces/setup)
  (yabai/setup)
  (front-app/setup))

(defn center-items [])

(defn right-items []
  (time/setup)
  (date/setup)
  (weather/setup)
  (battery/setup)
  (mic/setup)
  (volume/setup)
  (wifi/setup)
  (kubectx/setup)
  (gcloud/setup)
  (pr/setup)
  (github/setup)
  (brew/setup))

(defn -main [& args]
  (init)

  (left-items)
  (center-items)
  (right-items)

  (sketchybar/update))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
