(ns colors
  (:refer-clojure :exclude [get]))

(def palette
  {:black "0xff101317"
   :darker-black "0xff0a0d11"
   :transparent-black "0xb3000000"
   :white "0xffd4d4d5"
   :red "0xfff87070"
   :green "0xff37d99e"
   :blue "0xff7ab0df"
   :cyan "0xff50cad2"
   :yellow "0xffffe59e"
   :orange "0xfff0a988"
   :magenta "0xffc6a0f6"
   :grey "0xff3e4145"
   :cream "0xfff5ead5"
   :transparent "0x00000000"})

(defn get [key]
  (clojure.core/get palette key))

(def bar
  (get :transparent-black))

(def icon
  (get :cream))

(def label
  (get :cream))

(def popup-background
  (get :transparent-black))

(def popup-border
  (get :grey))

(def shadow
  (get :darker-black))
