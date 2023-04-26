(ns icons
  (:refer-clojure :exclude [get]))

(def icons
  {:yabai {:stack ""
           :fullscreen-zoom ""
           :parent-zoom ""
           :float ""
           :grid "󰕰"}
   :battery {:100 ""
             :75 ""
             :50 ""
             :25 ""
             :0 ""
             :charging "󰚥"}
   :wifi {:off "󰖪"
          :disconnected "󱚼"
          :connected "󰖩"}
   :net {:upload "󰕒"
         :download "󰇚"}
   :volume {:unmute "󰋋"
            :mute "󰟎"}
   :mic {:unmute ""
         :mute ""}
   :github {:octocat ""
            :issue ""
            :discussion ""
            :pullreq ""
            :exclamation ""
            :check ""}
   :gcloud ""
   :k8s "⎈"})

(defn get [& ks]
  (get-in icons ks))

(comment
  (get :github :octocat)
  (get :k8s))
