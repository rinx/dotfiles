(ns sbar.plugins.yabai
  (:require
   [sbar.colors :as colors]
   [sbar.external.yabai :as yabai]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn -icon-and-color [window]
  (cond
    (:is-floating window) {:icon (icons/get :yabai :float)
                           :icon.color (colors/get :light-green)}
    (:has-fullscreen-zoom window) {:icon (icons/get :yabai :fullscreen-zoom)
                                   :icon.color (colors/get :light-green)}
    (:has-parent-zoom window) {:icon (icons/get :yabai :parent-zoom)
                               :icon.color (colors/get :light-green)}
    :else {:icon (icons/get :yabai :grid)
           :icon.color (colors/get :light-green)}))

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
           :icon.color (colors/get :light-green)})
        (into {:label.drawing :off} (-icon-and-color window)))))))

(defn -main [& args]
  (let [sender (System/getenv "SENDER")]
    (when (not= sender "forced")
      (when (= sender "mouse.clicked")
        (yabai/toggle-float))
      (update-icon))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))

