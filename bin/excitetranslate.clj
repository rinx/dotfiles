#!/usr/bin/env bb

(require '[babashka.curl :as curl])
(require '[clojure.string :as string])

(def endpoint
  "https://www.excite.co.jp/world/english_japanese/")

(defn request [query mode]
  (curl/post endpoint
             {:form-params
              {"before" query
               "wb_lp" mode}}))

(defn en->ja [query]
  (let [body (:body (request query "ENJA"))
        results (re-find #"<textarea id=\"after\".*>(\S+)</textarea>" body)]
    (get results 1)))

(defn preprocess [query]
  (string/trim-newline query))

(-> (slurp *in*)
    (preprocess)
    (en->ja))
