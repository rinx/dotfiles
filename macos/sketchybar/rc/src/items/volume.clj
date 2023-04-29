(ns items.volume
  (:require
   [colors]
   [common]
   [fonts]
   [sketchybar]))

(defn -main [& args]
  (sketchybar/exec
   (sketchybar/add-item :volume :right)
   (sketchybar/set
    :volume
    {:script (common/plugin-script "volume.jar")
     :update_freq 3
     :background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 12.0)
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})
   (sketchybar/subscribe :volume :volume_change)
   (sketchybar/subscribe :volume :mouse.clicked)))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
