#!/usr/bin/env hy

(require hyrule [-> ->>])

(import argparse)
(import json)

(import torch)
(import transformers [AutoModel AutoTokenizer])
(import sentence_transformers [CrossEncoder])

(import duckdb)

(defn ->vec [query]
  (let [tokenizer (AutoTokenizer.from_pretrained
                    "pfnet/plamo-embedding-1b"
                    :trust_remote_code True)
        model (-> (AutoModel.from_pretrained
                    "pfnet/plamo-embedding-1b"
                    :trust_remote_code True)
                  (.to (if (torch.cuda.is_available) "cuda" "cpu")))]
    (with [_ (torch.inference_mode)]
      (-> query
          (model.encode_query tokenizer)
          (.cpu)
          (.squeeze)
          (.numpy)
          (.tolist)))))

(defn q [conn vec limit]
  (let [results (-> (conn.sql
                      "SELECT node_id, element_id, category, content, array_cosine_distance(content_v, ?::FLOAT[2048]) as distance FROM roam_doc ORDER BY distance LIMIT ?;"
                      :params [vec limit])
                    (.fetchall))]
    (lfor result results
      {:node-id (get result 0)
       :category (get result 2)
       :content (get result 3)
       :distance (get result 4)})))

(defn search [conn query limit]
  (let [vec (->vec query)]
    (q conn vec limit)))

(defn rerank [results query]
  (let [model (-> (CrossEncoder
                    "hotchpotch/japanese-reranker-cross-encoder-small-v1"
                    :max_length 512
                    :device (if (torch.cuda.is_available) "cuda" "cpu")))
        scores (-> (lfor result results
                     #(query (get result :content)))
                   (model.predict))]
    (-> (lfor [result score] (zip results scores)
          {"node-id" (get result :node-id)
           "category" (get result :category)
           "content" (get result :content)
           "score" score})
        (sorted :key (fn [x]
                       (get x "score"))
                :reverse True))))

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

(let [parser (argparse.ArgumentParser :description "search")
      _ (parser.add_argument "query")
      _ (parser.add_argument "limit")
      args (parser.parse_args)
      conn (duckdb.connect "~/.cache/nvim/roam_duckdb.db")]
  (-> conn
      (search args.query args.limit)
      (rerank args.query)
      (fmt)
      (print)))
