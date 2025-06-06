#!/usr/bin/env bb

;; gcloud named configurations switcher

(require '[babashka.process :as p]
         '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string]
         '[clojure.tools.cli :refer [parse-opts]])

(def cli-opts
  [["-c" "--current" "show the current configuration name"]
   ["-h" "--help"]])

(defn show-help [summary]
  (->> ["gctx - gcloud named configurations switcher"
        ""
        "Options:"
        summary]
       (string/join "\n")
       (print)))

(defn fzf [ss]
  (let [proc (p/process ["fzf" "-m"]
                        {:in (->> ss
                                  (string/join "\n"))
                         :err :inherit
                         :out :string})]
    (:out @proc)))

(defn set-config [n]
  (when n
    (sh "gcloud" "config" "configurations" "activate" n)
    (print (str "switched to " n))))

(defn ->entry [values]
  (zipmap [:name :active? :account :project
           :compute-default-zone :compute-default-region]
          values))

(defn get-entries []
  (let [result (sh "gcloud" "config" "configurations" "list")]
    (when (:out result)
      (->> (:out result)
           (string/split-lines)
           (map #(string/split % #"\s+"))
           (rest)
           (map ->entry)))))

(defn show-current-config []
  (->> (get-entries)
       (filter (fn [e]
                 (= (:active? e) "True")))
       (first)
       :name
       (print)))

(defn select-config []
  (let [entries (get-entries)]
    (-> entries
        (->> (map (fn [e]
                    (str (:name e) " - " (:project e) " (" (:account e) ")"))))
        (fzf)
        (string/split #"\s")
        (first)
        (set-config))))

(let [opts (parse-opts *command-line-args* cli-opts)]
  (cond
    (get-in opts [:options :help]) (show-help (:summary opts))
    (get-in opts [:options :current]) (show-current-config)
    :else (select-config)))

;; vim: set ft=clojure:
