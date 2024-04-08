(ns items.spaces
  (:require
   [colors]
   [common]
   [fonts]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn ->space [i icon]
  (let [idx (inc i)
        item (str "space." idx)]
    (flatten
     [(sketchybar/add-space item :left)
      (sketchybar/set
       item
       {:associated_space idx
        :background.height 18
        :background.corner_radius 4
        :icon icon
        :icon.padding_right 4
        :icon.font (fonts/get :Medium 16.0)
        :label.font (fonts/get :Medium 16.0)
        :script (common/plugin-script "spaces.jar")})
      (sketchybar/subscribe item :front_app_switched)])))

(defn setup []
  (apply sketchybar/exec (map-indexed ->space icons/spaces)))

(defn -main [& args]
  (setup))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
