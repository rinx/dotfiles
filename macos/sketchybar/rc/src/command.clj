(ns command
  (:require
   [babashka.process :refer [shell]]
   [clojure.java.io :as io]))

(def home
  (System/getenv "HOME"))

(def bb-path
  (-> (io/file home ".bin" "bb")
      (.getPath)))

(def plugins-dir
  (-> (io/file home ".config" "sketchybar" "rc" "target" "plugins")
      (.getPath)))

(defn sh [& cmds]
  (-> (apply shell {:out :string} cmds)
      :out))

(defn sketchybar [& args]
  (apply shell "sketchybar" args))

