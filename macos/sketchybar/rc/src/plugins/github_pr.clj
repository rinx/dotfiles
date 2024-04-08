(ns plugins.github-pr
  (:require
   [camel-snake-kebab.core :as csk]
   [cheshire.core :as json]
   [clojure.string :as str]
   [colors]
   [common]
   [icons]
   [sketchybar.core :as sketchybar]))

(defn prs []
  (-> (common/sh "gh" "search" "prs" "--state=open" "--review-requested=@me" "--json=repository,url,title")
      (json/parse-string csk/->kebab-case-keyword)))

(defn ->element [idx {:keys [repository title url]}]
  (let [item (str "github.prlist." idx)
        add-args (sketchybar/add-item item :popup.github.pr)
        set-args (sketchybar/set
                  item
                  {:background.padding_left 7
                   :background.padding_right 7
                   :background.color (colors/get :transparent-black)
                   :background.drawing :off
                   :icon (str
                          (icons/get :github :pullreq)
                          \space
                          (:name-with-owner repository))
                   :icon.background.height 1
                   :icon.background.y_offset -12
                   :icon.padding_left 0
                   :icon.color (colors/get :light-green)
                   :label title
                   :click_script
                   (str/join
                    "\n"
                    [(str "open " url)
                     "sketchybar --set github.pr popup.drawing=off"])})]
    (flatten [add-args set-args])))

(defn -main [& args]
  (let [prs (prs)]
    (sketchybar/exec
     ["--remove" "/github.prlist\\.*/"]
     (sketchybar/set (System/getenv "NAME") {:label (count prs)})
     (map-indexed ->element prs))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
