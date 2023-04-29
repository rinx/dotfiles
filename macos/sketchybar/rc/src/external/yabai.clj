(ns external.yabai
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [common]))

(defn windows [sid]
  (-> (common/sh "yabai" "-m" "query" "--windows" "--space" sid)
      (json/parse-string csk/->kebab-case-keyword)))

(comment
  (map :app (windows 1)))
