(ns plugins.battery
  (:require
   [clojure.string :as str]
   [sketchybar]
   [common]
   [icons]))

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
  (let [info (common/sh "pmset" "-g" "batt")
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
        (sketchybar/exec
         (sketchybar/set (System/getenv "NAME") {:label (str percentage "%")
                                                 :icon icon}))))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
