#!/usr/bin/env bb

;; create ~/.git-profiles.edn first.
;;
;; $ cat ~/.git-profiles.edn
;; {:default {:name "Rintaro Okamura"
;;            :email "xxx@gmail.com"}
;;  :alt {:name "rinx"
;;        :email "xxx@example.jp"
;;        :signingkey "XXXX"}}

(require '[babashka.process :as p]
         '[clojure.edn :as edn]
         '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(def git-profiles-edn
  (str (System/getenv "HOME") "/.git-profiles.edn"))

(defn fzf [ss]
  (let [proc (p/process ["fzf" "-m"]
                        {:in (->> ss
                                  (string/join "\n"))
                         :err :inherit
                         :out :string})]
    (:out @proc)))

(defn set-config [profile]
  (when profile
    (sh "git" "config" "user.name" (:name profile))
    (sh "git" "config" "user.email" (:email profile))
    (if (:signingkey profile)
      (do
        (sh "git" "config" "user.signingkey" (:signingkey profile))
        (sh "git" "config" "commit.gpgsign" "true"))
      (do
        (sh "git" "config" "--unset" "user.signingkey")
        (sh "git" "config" "--unset" "commit.gpgsign")))
    (print (str "switched to " (:name profile) " (" (:email profile) ")"))))

(let [profiles (-> (slurp git-profiles-edn)
                   (edn/read-string))]
  (-> profiles
      (->> (map (fn [[k v]]
                  (str (name k) " - " (:name v) " (" (:email v) ")"))))
      (fzf)
      (string/split #"\s")
      (first)
      (keyword)
      profiles
      (set-config)))

;; vim: set ft=clojure:
