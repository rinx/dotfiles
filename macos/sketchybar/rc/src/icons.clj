(ns icons
  (:refer-clojure :exclude [get]))

(def icons
  {:yabai {:stack ""
           :fullscreen-zoom "󰊓"
           :parent-zoom "󰖯"
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
   :info "󰋼"
   :beer ""
   :package "󰏗"
   :gcloud ""
   :celsius "󰔄"
   :k8s "󱃾"})

(def spaces
  ["󰎦 " "󰎩 " "󰎬 " "󰎮 " "󰎰 " "󰎵 " "󰎸 " "󰎻 " "󰎾 " "󰎣 "])

(defn get [& ks]
  (get-in icons ks))

(defn window [n]
  (case n
    "Google Chrome" ""
    "Arc" "󰲇"
    "kitty" "󰆍"
    "Finder" "󰀶"
    "Microsoft Teams" "󰊻"
    "goneovim" ""
    ""))

(comment
  (get :github :octocat)
  (get :k8s))
