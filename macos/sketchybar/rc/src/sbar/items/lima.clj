(ns sbar.items.lima
  (:require
   [clojure.string :as str]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn running? []
  (-> (common/sh "limactl" "list" "--yq" ".name,.status")
      (str/starts-with? "nixos Running")))

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
  (let [opts (if (running?)
               {:drawing :on
                :label "nixos"}
               {:drawing :off})]
    (sketchybar/exec
     (sketchybar/set :lima.vm opts))))
