(ns plugins.kubectx
  (:require
   [clojure.string :as str]
   [colors]
   [common]
   [icons]
   [sketchybar.core :as sketchybar]))

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

(defn -main [& args]
  (sketchybar/exec
   ["--remove" "/kubectx.list\\.*/"]
   (sketchybar/set (System/getenv "NAME") {:label (current-context)})
   (map-indexed ->element (contexts))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
