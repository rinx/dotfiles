(ns plugins.spaces
  (:require
   [clojure.string :as str]
   [colors]
   [common]
   [external.yabai :as yabai]
   [icons]
   [sketchybar]))

(defn ->space-icons [i _]
  (let [idx (inc i)
        item (str "space." idx)
        icons (->> (yabai/windows idx)
                   (map :app)
                   (map icons/window)
                   (str/join " "))]
    (when (not-empty icons)
      (sketchybar/set item {:label icons}))))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/set
    (System/getenv "NAME")
    (into {:icon.color (colors/get :black)
           :label.color (colors/get :black)
           :background.padding_left 3
           :background.padding_right 3}
          (if (= (System/getenv "SELECTED") "true")
            {:background.color (colors/get :cream)
             :background.border_color (colors/get :cream)}
            {:background.color (colors/get :grey)
             :background.border_color (colors/get :grey)})))
   (when (= (System/getenv "SENDER") "front_app_switched")
     (->> (map-indexed ->space-icons icons/spaces)
          (filter some?)))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
