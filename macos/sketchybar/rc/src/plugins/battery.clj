(ns plugins.battery
  (:require
   [clojure.string :as str]
   [command :as command]
   [icons :as icons]))

(defn ->icon [percentage charging]
  (->> (if charging
         :charging
         (condp < percentage
           85 :100
           60 :75
           30 :50
           10 :25
           :0))
       (icons/get :battery)))

(defn -main [& args]
  (let [info (command/sh "pmset" "-g" "batt")
        percentage (-> info
                       (->> (re-matcher #"\d+%")
                            (re-find))
                       (str/replace "%" "")
                       (Integer/parseInt))
        charging (-> info
                     (->> (re-matcher #"AC Power")
                          (re-find))
                     (some?))]
    (if (nil? percentage)
      nil
      (let [icon (->icon percentage charging)]
        (command/sketchybar
         "--set" (System/getenv "NAME")
         (str "label=" percentage "%")
         (str "icon=" icon ""))))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
