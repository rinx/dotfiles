(ns items.battery
  (:require
   [command :as command]
   [colors :as colors]
   [fonts :as fonts]))

(command/sketchybar
 "--add" "item" "battery" "right"
 "--set" "battery"
 (str "script=" command/bb-path " " command/plugins-dir "/battery.jar")
 "update_freq=5"
 (str "background.color=" (colors/get :cream))
 (str "label.color=" (colors/get :black))
 (str "icon.color=" (colors/get :black))
 (str "label.font=" fonts/default ":Medium:12.0")
 (str "icon.font=" fonts/default ":Medium:14.0")
 "background.height=15"
 "background.corner_radius=4"
 "--subscribe" "battery" "system_woke")
