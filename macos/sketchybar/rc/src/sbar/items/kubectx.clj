(ns sbar.items.kubectx
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :kubectx.current :right)
   (sketchybar/set
    :kubectx.current
    {:click_script "sketchybar --set $NAME popup.drawing=toggle"
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon (icons/get :k8s)
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(defn format-context-name [ctx]
  (let [es (str/split ctx #"_")]
    (str/join "_" [(second es) (nth es 3)])))

(defn contexts []
  (->> (common/sh "kubectl" "config" "get-contexts" "-o=name")
       (str/split-lines)))

(defn current-context []
  (-> (common/sh "kubectl" "config" "current-context")
      (str/trim-newline)
      (format-context-name)))

(defn ->element [idx ctx]
  (let [item (str "kubectx.list." idx)
        add-args (sketchybar/add-item item :popup.kubectx.current)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (icons/get :k8s)
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label (format-context-name ctx)
                   :click_script
                   (str/join
                    "\n"
                    [(str "kubectl config use-context " ctx)
                     (str "sketchybar --set kubectx.current label="
                          (format-context-name ctx))
                     "sketchybar --set kubectx.current popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn update []
  (sketchybar/exec
   ["--remove" "/kubectx.list\\.*/"]
   (sketchybar/set :kubectx.current {:label (current-context)})
   (map-indexed ->element (contexts))))
