(ns plugins.gcloud
  (:require
   [clojure.string :as str]
   [sketchybar]
   [common]
   [colors]
   [icons]))

(defn contexts []
  (->> (common/sh "gcloud" "config" "configurations" "list" "--format" "value(name)")
       (str/split-lines)))

(defn current-context []
  (->> (common/sh "gcloud" "config" "list" "--format" "value(core.project)")
       (str/trim-newline)))

(defn ->element [idx ctx]
  (let [item (str "gcloud.list." idx)
        add-args (sketchybar/add-item item :popup.gcloud.current)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (icons/get :gcloud)
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label ctx
                   :click_script
                   (str/join
                    "\n"
                    [(str "gcloud config configurations activate " ctx)
                     (str "sketchybar --set gcloud.current label=" ctx)
                     "sketchybar --set gcloud.current popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn -main [& args]
  (sketchybar/exec
   ["--remove" "/gcloud.list\\.*/"]
   (sketchybar/set (System/getenv "NAME") {:label (current-context)})
   (map-indexed ->element (contexts))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
