(ns plugins.network
  (:require
   [clojure.string :as str]
   [sketchybar]
   [common]
   [icons]))

(defn ifstat-updown []
  (-> (common/sh "ifstat" "-i" "en0" "-b" "0.1" "1")
      (str/split-lines)
      (last)
      (str/split #" ")
      (->> (filter not-empty)
           (map (fn [x]
                  (/ (Float/parseFloat x) 8)))
           (zipmap [:down :up]))))

(defn -main [& args]
  (let [{:keys [up down]} (ifstat-updown)
        up? (> up down)
        icon (if up?
               (icons/get :net :upload)
               (icons/get :net :download))
        value (if up?
                up
                down)
        label (if (> value 999)
                (format "%.1fMB/s" (/ value 1000))
                (format "%.1fKB/s" value))]
    (sketchybar/exec
     (sketchybar/set
      (System/getenv "NAME")
      {:icon icon
       :label label}))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
