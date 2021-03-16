#!/usr/bin/env bb

(ns deps-update
  (:require
    [clojure.string :as string]
    [clojure.edn :as edn]
    [babashka.curl :as curl]
    [cheshire.core :as json]))

(defn replace-with [file versions]
  (loop [file file
         versions versions]
    (if-let [v (first versions)]
      (let [name (:name v)
            version (:version v)
            pattern (re-pattern (str "ARG " name "=.*"))
            replaced (string/replace file pattern (str "ARG " name "=" version))]
        (recur replaced (rest versions)))
      file)))

(let [dockerfile (slurp "Dockerfile")
      deps (->> dockerfile
                (string/split-lines)
                (filter #(re-matches #"^## --- .*" %))
                (map #(string/replace % #"^## --- " ""))
                (string/join "\n")
                (edn/read-string))
      versions (->> deps
                    (map (fn [{:keys [name url tx]}]
                           (let [version (when (not-empty url)
                                           (-> (curl/get url)
                                               :body
                                               (json/parse-string)
                                               (first)
                                               (get "name")))
                                 version (if tx
                                           ((eval (read-string tx)) version)
                                           version)]
                               {:name name :version version}))))
      replaced (replace-with dockerfile versions)]
  (spit "Dockerfile" replaced))
