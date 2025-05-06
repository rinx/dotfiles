#!/usr/bin/env hy

(require hyrule [-> ->>])

(import argparse)
(import json)

(import torch)
(import transformers [AutoModel AutoTokenizer])
(import lindera_py [Segmenter Tokenizer load_dictionary])
(import sentence_transformers [CrossEncoder])

(import duckdb)

(setv vec-tokenizer (AutoTokenizer.from_pretrained
                      "pfnet/plamo-embedding-1b"
                      :trust_remote_code True))
(setv vec-model (-> (AutoModel.from_pretrained
                      "pfnet/plamo-embedding-1b"
                      :trust_remote_code True)
                    (.to (if (torch.cuda.is_available)
                           "cuda"
                           "cpu"))))

(setv ja-tokenizer (let [dictionary (load_dictionary "ipadic")
                         segmenter (Segmenter "normal" dictionary)]
                     (Tokenizer segmenter)))

(defn ->vec [query]
  (with [_ (torch.inference_mode)]
    (-> query
        (vec-model.encode_query vec-tokenizer)
        (.cpu)
        (.squeeze)
        (.numpy)
        (.tolist))))


(defn ja-tokens [txt]
  (let [ts (ja-tokenizer.tokenize txt)]
    (->> (lfor t ts
           t.text)
         (.join " "))))

(defn vq [conn vec limit title-only]
  (let [results (-> (if title-only
                      (conn.sql
                        "SELECT node_id, element_id, category, content, array_cosine_distance(content_v, ?::FLOAT[2048]) as distance FROM roam_doc WHERE category = 'Title' ORDER BY distance LIMIT ?;"
                        :params [vec limit])
                      (conn.sql
                        "SELECT node_id, element_id, category, content, array_cosine_distance(content_v, ?::FLOAT[2048]) as distance FROM roam_doc ORDER BY distance LIMIT ?;"
                        :params [vec limit]))
                    (.fetchall))]
    (lfor result results
      {:node-id (get result 0)
       :element-id (get result 1)
       :category (get result 2)
       :content (get result 3)
       :distance (get result 4)})))

(defn tq [conn tok limit title-only]
  (let [results (-> (if title-only
                      (conn.sql
                        "SELECT node_id, element_id, category, content, fts_main_roam_doc.match_bm25(element_id, ?) AS score FROM roam_doc WHERE score IS NOT NULL AND category = 'Title' ORDER BY score DESC LIMIT ?;"
                        :params [tok limit])
                      (conn.sql
                        "SELECT node_id, element_id, category, content, fts_main_roam_doc.match_bm25(element_id, ?) AS score FROM roam_doc WHERE score IS NOT NULL ORDER BY score DESC LIMIT ?;"
                        :params [tok limit]))
                    (.fetchall))]
    (lfor result results
      {:node-id (get result 0)
       :element-id (get result 1)
       :category (get result 2)
       :content (get result 3)
       :score (get result 4)})))

(defn search [conn query limit title-only]
  (let [vec (->vec query)
        tok (ja-tokens query)
        vr (vq conn vec limit title-only)
        tr (tq conn tok limit title-only)
        seen (set)]
    ;; merge results
    (+
      (lfor result vr
        (do
          (.add seen (get result :element-id))
          result))
      (lfor result tr
        :if (not (in (get result :element-id) seen))
        result))))

(defn take [ls limit]
  (lfor [i l] (enumerate ls)
    :if (< i limit)
    l))

(defn rerank [results query limit]
  (let [model (-> (CrossEncoder
                    "hotchpotch/japanese-reranker-cross-encoder-small-v1"
                    :max_length 512
                    :device (if (torch.cuda.is_available) "cuda" "cpu")))
        scores (-> (lfor result results
                     #(query (get result :content)))
                   (model.predict))
        lim (int limit)]
    (-> (lfor [result score] (zip results scores)
          {"node-id" (get result :node-id)
           "category" (get result :category)
           "content" (get result :content)
           "score" score})
        (sorted :key (fn [x]
                       (get x "score"))
                :reverse True)
        (take lim))))

(defn fmt [results]
  (let [encode-score (fn [xs]
                       (lfor x xs
                         (let [score (get x "score")]
                           (x.update :score (str score))
                           x)))]
    (-> results
        encode-score
        (json.dumps
          :separators ["," ":"]
          :ensure_ascii False))))

(defn init-db []
  (let [conn (duckdb.connect "~/.cache/nvim/roam_duckdb.db")]
    (conn.install_extension "vss")
    (conn.load_extension "vss")
    (conn.install_extension "fts")
    (conn.load_extension "fts")
    conn))

(let [parser (argparse.ArgumentParser :description "search")
      _ (parser.add_argument "query")
      _ (parser.add_argument "limit")
      _ (parser.add_argument "--title_only" :action "store_true")
      args (parser.parse_args)
      conn (init-db)]
  (-> conn
      (search args.query args.limit args.title_only)
      (rerank args.query args.limit)
      (fmt)
      (print)))
