(ns sbar.plugins.spaces
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.external.yabai :as yabai]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn ->space-icons [i _]
  (let [idx (inc i)
        item (str "space." idx)
        icons (->> (yabai/windows idx)
                   (map :app)
                   (map icons/app-font) ;; (map icons/window)
                   (str/join " "))]
    (sketchybar/set item {:label (if (not-empty icons) icons " ")})))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/set
    (System/getenv "NAME")
    (into {:background.color (colors/get :transparent-black)
           :background.border_color (colors/get :transparent-black)
           :background.padding_left 3
           :background.padding_right 3}
          (if (= (System/getenv "SELECTED") "true")
            {:icon.color (colors/get :light-green)
             :label.color (colors/get :cream)}
            {:icon.color (colors/get :black)
             :label.color (colors/get :black)})))
   (when (= (System/getenv "SENDER") "front_app_switched")
     (->> (map-indexed ->space-icons icons/spaces)
          (filter some?)))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
