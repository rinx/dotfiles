(ns sbar.external.yabai
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [sbar.common :as common]))

(defn windows [sid]
  (-> (common/sh "yabai" "-m" "query" "--windows" "--space" sid)
      (json/parse-string csk/->kebab-case-keyword)))

(defn window [& args]
  (-> (apply common/sh "yabai" "-m" "query" "--windows" "--window" args)
      (json/parse-string csk/->kebab-case-keyword)))

(defn toggle-float []
  (common/sh "yabai" "-m" "window" "--toggle" "float")
  (common/sh "yabai" "-m" "window" "--grid" "4:4:1:1:2:2"))

(comment
  (map :app (windows 1))

  (window)

  (toggle-float))
