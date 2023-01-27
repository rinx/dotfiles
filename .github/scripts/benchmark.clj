#!/usr/bin/env bb

(ns benchmark
  (:require
   [babashka.process :as process :refer [shell]]
   [cheshire.core :as json]))

(def zsh
  "zsh -i -c exit")

(def nvim
  "nvim --headless -c 'qall'")

(defmacro time'
  "Returns the time expr took in ms.
  https://github.com/clojure/clojure/blob/clojure-1.10.1/src/clj/clojure/core.clj#L3884"
  [expr]
  `(let [start# (. System (nanoTime))
         ret# ~expr]
     (/ (double (- (. System (nanoTime)) start#)) 1000000.0)))

(defn bench [n cmd]
  (take n
    (repeatedly
      #(time' (shell cmd)))))

(defn avg [coll]
  (/ (reduce + coll) (count coll)))

(print
  (json/generate-string
    [{:name "zsh load time"
      :unit "ms"
      :value (avg (bench 10 zsh))}
     {:name "neovim load time"
      :unit "ms"
      :value (avg (bench 10 nvim))}]))

(comment
  (time' (shell zsh))
  (time' (shell nvim))

  (bench 3 zsh)
  (bench 3 nvim)

  (avg (bench 3 zsh))
  (avg (bench 3 nvim)))
