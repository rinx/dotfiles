#!/usr/bin/env hy

(require hyrule [-> ->>])

(import argparse)
(import json)

(import torch)
(import transformers [AutoModel AutoTokenizer])

(import duckdb)

(defn ->vec [query]
  (let [tokenizer (AutoTokenizer.from_pretrained
                    "pfnet/plamo-embedding-1b"
                    :trust_remote_code True)
        model (-> (AutoModel.from_pretrained
                    "pfnet/plamo-embedding-1b"
                    :trust_remote_code True)
                  (.to (if (torch.cuda.is_available)
                         "cuda"
                         "cpu")))]
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
      {"node_id" (get result 0)
       "element_id" (get result 1)
       "category" (get result 2)
       "content" (get result 3)
       "distance" (get result 4)})))

(defn search [conn query limit]
  (let [vec (->vec query)]
    (q conn vec limit)))

(let [parser (argparse.ArgumentParser :description "search")
      _ (parser.add_argument "query")
      _ (parser.add_argument "limit")
      args (parser.parse_args)
      conn (duckdb.connect "~/.cache/nvim/roam_duckdb.db")]
  (-> conn
      (search args.query args.limit)
      (json.dumps
        :separators ["," ":"]
        :ensure_ascii False)
      (print)))
