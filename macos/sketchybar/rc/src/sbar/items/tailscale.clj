(ns sbar.items.tailscale
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn exists? []
  (when (common/sh "which" "tailscale")
    true))

(defn online? []
  (-> (common/sh "tailscale" "status" "--json")
      (json/parse-string csk/->kebab-case-keyword)
      (get-in [:self :online])))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :tailscale :right)
   (sketchybar/set
    :tailscale
    {:drawing :off
     :icon (icons/get :vpn)
     :icon.font (fonts/get :Medium 12.0)
     :icon.color (colors/get :cyan)})))

(defn update []
  (let [opts (if (exists?)
               {:drawing :on
                :label (if (online?) "online" "offline")}
               {:drawing :off})]
    (sketchybar/exec
     (sketchybar/set :tailscale opts))))
