(ns sbar.items.volume
  (:require
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :volume :right)
   (sketchybar/set
    :volume
    {:script (common/plugin-script "volume.jar")
     :update_freq 20
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :volume :volume_change :mouse.clicked)))
