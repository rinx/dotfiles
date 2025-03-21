(ns sbar.common
  (:require
   [babashka.process :refer [shell]]
   [clojure.java.io :as io]))

(def home
  (System/getenv "HOME"))

(def bb-path
  (-> (io/file home ".nix-profile" "bin" "bb")
      (.getPath)))

(def plugins-dir
  (-> (io/file home ".config" "sketchybar" "rc" "target" "plugins")
      (.getPath)))

(defn plugin-script [filename]
  (str bb-path " " plugins-dir "/" filename))

(defn sh [& cmds]
  (try
    (-> (apply shell {:out :string} cmds)
        :out)
    (catch Exception _
      nil)))
