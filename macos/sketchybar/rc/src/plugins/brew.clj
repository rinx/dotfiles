(ns plugins.brew
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [clojure.string :as str]
   [colors]
   [common]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn outdated []
  (-> (common/sh "brew" "outdated" "--json")
      (json/parse-string csk/->kebab-case-keyword)
      :formulae))

(defn ->element [idx pkg]
  (let [item (str "brew.outdated.list." idx)
        pkg-name (:name pkg)
        version (:current-version pkg)
        add-args (sketchybar/add-item item :popup.brew.outdated)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (str (icons/get :package) \space pkg-name)
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label version
                   :click_script
                   (str/join
                    "\n"
                    [(str "open https://formulae.brew.sh/formula/" pkg-name)
                     "sketchybar --set brew.outdated popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn -main [& args]
  (let [outdated-pkgs (outdated)
        cnt (count outdated-pkgs)]
    (sketchybar/exec
     ["--remove" "/brew.outdated.list\\.*/"]
     (sketchybar/set (System/getenv "NAME") {:drawing (if (zero? cnt) :off :on)
                                             :label cnt})
     (map-indexed ->element outdated-pkgs))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
