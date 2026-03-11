(ns sbar.items.lima
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn statuses []
  (-> (common/sh "limactl" "list" "--yq" "[{\"name\": .name, \"status\": .status}]")
      (json/parse-string csk/->kebab-case-keyword)))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :lima.vm :right)
   (sketchybar/set
    :lima.vm
    {:drawing :off
     :icon (icons/get :vm :active)
     :icon.font (fonts/get :Medium 12.0)
     :icon.color (colors/get :lima-green)})))

(defn update []
  (let [status (-> (statuses)
                   (first))
        opts (if status
               (merge
                (case (:status status)
                  "Running" {:icon (icons/get :vm :active)
                             :icon.color (colors/get :lima-green)}
                  "Stopped" {:icon (icons/get :vm :exist)
                             :icon.color (colors/get :light-grey)}
                  {:icon (icons/get :vm :outline)
                   :icon.color (colors/get :light-grey)})
                {:drawing :on
                 :label (:name status)})
               {:drawing :off})]
    (sketchybar/exec
     (sketchybar/set :lima.vm opts))))
