#!/usr/bin/env hy

(require hyrule [-> ->>])

(import json)
(import sys)
(import os)
(import hashlib)
(import functools [reduce])

(import torch)
(import transformers [AutoModel AutoTokenizer])
(import langchain_community.document_loaders [UnstructuredOrgModeLoader])
(import lindera_py [Segmenter Tokenizer load_dictionary])

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

(defn ja-tokens [txt]
  (let [ts (ja-tokenizer.tokenize txt)]
    (->> (lfor t ts
           t.text)
         (.join " "))))

(defn ->md5 [path]
  (with [f (open path "rb")]
    (-> (f.read)
        (hashlib.md5)
        (.hexdigest))))

(defn unstructured-org-content [path]
  (-> (UnstructuredOrgModeLoader
        :file_path path
        :mode "elements")
      (.load)))

(defn chunks [lst n]
  (lfor i (range 0 (len lst) n)
        (cut lst i (min (+ i n) (len lst)))))

(defn flatten [lst]
  (reduce
    (fn [a b]
      (let [n (.extend a b)]
        a))
    lst []))

(defn insert-doc [conn node-id doc emb]
  (let [element-id (.join ":" [node-id (get doc.metadata "element_id")])
        category (get doc.metadata "category")
        content doc.page_content
        vector (-> emb
                   (.cpu)
                   (.squeeze)
                   (.numpy)
                   (.tolist))
        tokens (ja-tokens content)]
    (conn.execute
      "INSERT INTO roam_doc (node_id, element_id, category, content, content_v, content_t) VALUES (?, ?, ?, ?, ?, ?);"
      [node-id
       element-id
       category
       content
       vector
       tokens])
    {"node_id" node-id
     "element_id" element-id
     "category" category
     "content" content
     "content_v" vector
     "content_t" tokens}))

(defn insert-embeddings [conn node-id docs]
  (with [_ (torch.inference_mode)]
    (-> (lfor chunk (chunks docs 10)
          (let [embs (-> (lfor doc chunk
                          (. doc page_content))
                         (vec-model.encode_document vec-tokenizer))]
            (setv results [])
            (for [[doc emb] (zip chunk embs)]
              (results.append
                (insert-doc conn node-id doc emb)))
            results))
        (flatten))))

(defn unstructured-and-insert [conn node-id path]
  (let [docs (unstructured-org-content path)]
    (insert-embeddings conn node-id docs)))

(defn query-md5 [conn node-id]
  (let [results (-> (conn.sql
                      "SELECT md5 FROM roam_doc_md5 WHERE node_id = ?;"
                      :params [node-id])
                    (.fetchall))]
    (when (= (len results) 1)
      (-> results
          (get 0)
          (get 0)))))

(defn process [conn node-id path md5]
  (let [previous-md5 (query-md5 conn node-id)
        elems (if (not (= previous-md5 md5))
                (do
                  (conn.sql
                    "DELETE FROM roam_doc WHERE node_id = ?;"
                    :params [node-id])
                  (unstructured-and-insert conn node-id path))
                [])]
    {"node_id" node-id
     "path" path
     "md5" md5
     "elems" elems}))

(defn init-db []
  (let [conn (duckdb.connect "~/.cache/nvim/roam_duckdb.db")]
    (conn.install_extension "vss")
    (conn.load_extension "vss")
    (conn.install_extension "fts")
    (conn.load_extension "fts")
    (conn.sql "CREATE TABLE IF NOT EXISTS roam_doc_md5 (node_id TEXT, md5 TEXT, PRIMARY KEY (node_id));")
    (conn.sql "CREATE TABLE IF NOT EXISTS roam_doc (element_id TEXT, node_id TEXT, category TEXT, content TEXT, content_v FLOAT[2048], content_t TEXT, PRIMARY KEY (element_id));")
    conn))

(defn upsert-md5 [conn node-id md5]
  (conn.execute
    "INSERT OR REPLACE INTO roam_doc_md5 (node_id, md5) VALUES (?, ?);"
    [node-id md5]))

(defn update-fts-index [conn]
  (conn.sql "PRAGMA create_fts_index('roam_doc', 'element_id', 'content_t', stemmer = 'none', stopwords = 'none', ignore = '', lower = false, strip_accents = false, overwrite = true);"))

(defn commit [conn files]
  (update-fts-index conn)
  (for [file files]
    (let [node-id (get file "node_id")
          md5 (get file "md5")]
      (upsert-md5 conn node-id md5))))

(let [inputs (-> (sys.stdin.read)
                 (json.loads))
      conn (init-db)
      files (lfor inp inputs
              (let [node-id (get inp "node-id")
                    path (get inp "path")
                    md5 (->md5 path)]
                (process conn node-id path md5)))]
  (commit conn files))
