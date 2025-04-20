#!/usr/bin/env python

import argparse
import json
import sys

import torch
import torch.nn.functional as F
from transformers import AutoModel, AutoTokenizer

# model: https://huggingface.co/pfnet/plamo-embedding-1b
tokenizer = AutoTokenizer.from_pretrained("pfnet/plamo-embedding-1b", trust_remote_code=True)
model = AutoModel.from_pretrained("pfnet/plamo-embedding-1b", trust_remote_code=True)

device = "cuda" if torch.cuda.is_available() else "cpu"
model = model.to(device)

def encode_query(args):
    with torch.inference_mode():
        query_embedding = model.encode_query(sys.stdin.read(), tokenizer)
    vec = query_embedding.cpu().squeeze().numpy().tolist()
    print(json.dumps(vec, separators=(',', ":")))

def encode_documents(args):
    # must be formatted as {:id :string :title :string :aliases [:string]}
    inputs = json.loads(sys.stdin.read())
    titles = [doc["title"] for doc in inputs]

    with torch.inference_mode():
        document_embeddings = model.encode_document(titles, tokenizer)
        results = []
        for doc, doc_embedding in zip(inputs, document_embeddings):
            id = doc["id"]
            vec = doc_embedding.cpu().squeeze().numpy().tolist()
            results.append({"id": id, "vector": vec})
        print(json.dumps(results, separators=(',', ':')))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="calculate embeddings for given text by using pfnet/plamo-embedding-1b")
    subparsers = parser.add_subparsers(dest="subcommand")

    query_parser = subparsers.add_parser("query", help="encode query to embedding")
    query_parser.set_defaults(handler=encode_query)

    documents_parser = subparsers.add_parser("documents", help="encode documents to embeddings")
    documents_parser.set_defaults(handler=encode_documents)

    args = parser.parse_args()

    if hasattr(args, "handler"):
        args.handler(args)
    else:
        parser.print_help()
