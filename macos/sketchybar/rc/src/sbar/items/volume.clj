(ns sbar.items.volume
  (:require
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.colors :as colors]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :volume :right)
   (sketchybar/set
    :volume
    {:script (common/plugin-script "volume.jar")
     :update_freq 20
     :icon.font (fonts/get :Medium 12.0)
     :icon.color (colors/get :orange)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :volume :volume_change :mouse.clicked)))
