(ns sbar.items.weather
  (:require
   [babashka.http-client :as http]
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [sbar.colors :as colors]
   [sbar.common :as common]
   [sbar.fonts :as fonts]
   [sbar.icons :as icons]
   [sketchybar.core :as sketchybar]))

(defn setup []
  (sketchybar/exec
   (sketchybar/add-item :weather :right)
   (sketchybar/set
    :weather
    {:background.color (colors/get :cream)
     :background.corner_radius 4
     :background.height 15
     :icon "-"
     :icon.color (colors/get :black)
     :icon.font (fonts/get :Medium 14.0)
     :label.y_offset 1
     :label "-"
     :label.color (colors/get :black)
     :label.font (fonts/get :Medium 12.0)})))

(def weather-icon-descs
  {"113" {:icon "" :desc "Sunny"}
   "116" {:icon "" :desc "PartlyCloudy"}
   "119" {:icon "" :desc "Cloudy"}
   "122" {:icon "" :desc "VeryCloudy"}
   "143" {:icon "" :desc "Fog"}
   "176" {:icon "" :desc "LightShowers"}
   "179" {:icon "" :desc "LightSleetShowers"}
   "182" {:icon "" :desc "LightSleet"}
   "185" {:icon "" :desc "LightSleet"}
   "200" {:icon "" :desc "ThunderyShowers"}
   "227" {:icon "" :desc "LightSnow"}
   "230" {:icon "" :desc "HeavySnow"}
   "248" {:icon "" :desc "Fog"}
   "260" {:icon "" :desc "Fog"}
   "263" {:icon "" :desc "LightShowers"}
   "266" {:icon "" :desc "LightRain"}
   "281" {:icon "" :desc "LightSleet"}
   "284" {:icon "" :desc "LightSleet"}
   "293" {:icon "" :desc "LightRain"}
   "296" {:icon "" :desc "LightRain"}
   "299" {:icon "" :desc "HeavyShowers"}
   "302" {:icon "" :desc "HeavyRain"}
   "305" {:icon "" :desc "HeavyShowers"}
   "308" {:icon "" :desc "HeavyRain"}
   "311" {:icon "" :desc "LightSleet"}
   "314" {:icon "" :desc "LightSleet"}
   "317" {:icon "" :desc "LightSleet"}
   "320" {:icon "" :desc "LightSnow"}
   "323" {:icon "" :desc "LightSnowShowers"}
   "326" {:icon "" :desc "LightSnowShowers"}
   "329" {:icon "" :desc "HeavySnow"}
   "332" {:icon "" :desc "HeavySnow"}
   "335" {:icon "" :desc "HeavySnowShowers"}
   "338" {:icon "" :desc "HeavySnow"}
   "350" {:icon "" :desc "LightSleet"}
   "353" {:icon "" :desc "LightShowers"}
   "356" {:icon "" :desc "HeavyShowers"}
   "359" {:icon "" :desc "HeavyRain"}
   "362" {:icon "" :desc "LightSleetShowers"}
   "365" {:icon "" :desc "LightSleetShowers"}
   "368" {:icon "" :desc "LightSnowShowers"}
   "371" {:icon "" :desc "HeavySnowShowers"}
   "374" {:icon "" :desc "LightSleetShowers"}
   "377" {:icon "" :desc "LightSleet"}
   "386" {:icon "" :desc "ThunderyShowers"}
   "389" {:icon "" :desc "ThunderyHeavyRain"}
   "392" {:icon "" :desc "ThunderySnowShowers"}
   "395" {:icon "" :desc "HeavySnowShowers"}})

(defn weather []
  (-> (http/get "https://wttr.in?format=j1")
      :body
      (json/parse-string csk/->kebab-case-keyword)))

(defn ->weather-icon [code]
  (:icon (get weather-icon-descs code)))

(defn update []
  (let [current (-> (weather)
                    :current-condition
                    first)]
    (when current
      (let [icon (->weather-icon (:weather-code current))
            temp-c (:temp-c current)]
        (sketchybar/exec
         (sketchybar/set :weather {:icon icon
                                   :label (str temp-c (icons/get :celsius))}))))))
