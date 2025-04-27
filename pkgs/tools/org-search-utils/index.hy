#!/usr/bin/env hy

(require hyrule [-> ->>])

(import json)
(import sys)
(import hashlib)

(import torch)
(import transformers [AutoModel AutoTokenizer])
(import langchain_community.document_loaders [UnstructuredOrgModeLoader])

(import duckdb)

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

(defn embeddings [docs]
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
      (-> (lfor doc docs
           (. doc page_content))
          (model.encode_document tokenizer)))))

(defn convert [node-id path]
  (let [docs (unstructured-org-content path)]
    (setv results [])
    (let [embs (embeddings docs)]
      (for [[doc emb] (zip docs embs)]
        (results.append {"node_id" node-id
                         "element_id" (-> (. doc metadata)
                                          (get "element_id"))
                         "category" (-> (. doc metadata)
                                        (get "category"))
                         "content" (. doc page_content)
                         "content_v" (-> emb
                                         (.cpu)
                                         (.squeeze)
                                         (.numpy)
                                         (.tolist))}))
      results)))

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
                  (conn.execute
                    "INSERT OR REPLACE INTO roam_doc_md5 (node_id, md5) VALUES (?, ?);"
                    [node-id md5])
                  (convert node-id path))
                [])]
    {"node_id" node-id
     "path" path
     "elems" elems}))

(defn init-db []
  (let [conn (duckdb.connect "~/.cache/nvim/roam_duckdb/db")]
    (conn.sql "INSTALL vss;")
    (conn.sql "LOAD vss;")
    (conn.sql "CREATE TABLE IF NOT EXISTS roam_doc_md5 (node_id TEXT, md5 TEXT, PRIMARY KEY (node_id));")
    (conn.sql "CREATE TABLE IF NOT EXISTS roam_doc (node_id TEXT, element_id TEXT, category TEXT, content TEXT, content_v FLOAT[2048], PRIMARY KEY (node_id, element_id));")
    conn))

(defn insert-roam-doc [conn elems]
  (for [elem elems]
    (conn.execute
      "INSERT INTO roam_doc (node_id, element_id, category, content, content_v) VALUES (?, ?, ?, ?, ?);"
      [(get elem "node_id")
       (get elem "element_id")
       (get elem "category")
       (get elem "content")
       (get elem "content_v")])))

(defn ->db [conn files]
  (for [file files]
    (let [elems (get file "elems")]
      (insert-roam-doc conn elems))))

(let [inputs (-> (sys.stdin.read)
                 (json.loads))
      conn (init-db)
      files (lfor inp inputs
              (let [node-id (get inp "node-id")
                    path (get inp "path")
                    md5 (->md5 path)]
                (process conn node-id path md5)))]
  (->db conn files))
