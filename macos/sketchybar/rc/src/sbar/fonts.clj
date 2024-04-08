(ns sbar.fonts
  (:refer-clojure :exclude [get]))

(def default
  "JetBrainsMono Nerd Font")

(defn get
  ([style size]
   (get default style size))
  ([font style size]
   (str font ":" (name style) ":" size)))
