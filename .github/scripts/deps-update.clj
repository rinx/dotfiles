#!/usr/bin/env bb

(ns deps-update
  (:require
   [clojure.string :as string]
   [clojure.edn :as edn]
   [babashka.curl :as curl]
   [cheshire.core :as json]))

(defn replace-with [file versions pattern-fn replacer-fn]
  (loop [file file
         versions versions]
    (if-let [v (first versions)]
      (let [name (:name v)
            version (:version v)
            pattern (pattern-fn name)
            replaced (string/replace file pattern (replacer-fn name version))]
        (if version
          (recur replaced (rest versions))
          file))
      file)))

(defn do-update [filename pattern-fn replacer-fn]
  (let [body (slurp filename)
        deps (->> body
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
                                                 (get "tag_name")))
                                   version (if tx
                                             ((eval (read-string tx)) version)
                                             version)]
                               {:name name :version version}))))
        replaced (replace-with body versions pattern-fn replacer-fn)]
    (spit filename replaced)))

(do-update
 "Dockerfile"
 (fn [name]
   (re-pattern (str "ARG " name "=.*")))
 (fn [name version]
   (str "ARG " name "=" version)))

(do-update
 "Makefile.d/bin.mk"
 (fn [name]
   (re-pattern (str name " := .*")))
 (fn [name version]
   (str name " := " version)))
