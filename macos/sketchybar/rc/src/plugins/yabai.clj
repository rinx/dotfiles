(ns plugins.yabai
  (:require
   [colors]
   [external.yabai :as yabai]
   [icons]
   [sketchybar]))

(defn -icon-and-color [window]
  (cond
    (:is-floating window) {:icon (icons/get :yabai :float)
                           :icon.color (colors/get :magenta)}
    (:has-fullscreen-zoom window) {:icon (icons/get :yabai :fullscreen-zoom)
                                   :icon.color (colors/get :yellow)}
    (:has-parent-zoom window) {:icon (icons/get :yabai :parent-zoom)
                               :icon.color (colors/get :blue)}
    :else {:icon (icons/get :yabai :grid)
           :icon.color (colors/get :white)}))

(defn update-icon []
  (let [window (yabai/window)]
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      (if (> (:stack-index window) 0)
        (let [current (:stack-index window)
              last-index (:stack-index (yabai/window "stack.last"))]
          {:label (format "[%s/%s]" current last-index)
           :label.drawing :on
           :icon (icons/get :yabai :stack)
           :icon.color (colors/get :green)})
        (into {:label.drawing :off} (-icon-and-color window)))))))

(defn -main [& args]
  (let [sender (System/getenv "SENDER")]
    (when (not= sender "forced")
      (when (= sender "mouse.clicked")
        (yabai/toggle-float))
      (update-icon))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
