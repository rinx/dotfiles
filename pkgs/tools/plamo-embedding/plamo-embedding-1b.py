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

def encode_document(args):
    with torch.inference_mode():
        document_embeddings = model.encode_document([sys.stdin.read()], tokenizer)
    vec = document_embeddings[0].cpu().squeeze().numpy().tolist()
    print(json.dumps(vec, separators=(',', ":")))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="calculate embeddings for given text by using pfnet/plamo-embedding-1b")
    subparsers = parser.add_subparsers(dest="subcommand")

    query_parser = subparsers.add_parser("query", help="encode query to embedding")
    query_parser.set_defaults(handler=encode_query)

    document_parser = subparsers.add_parser("document", help="encode document to embedding")
    document_parser.set_defaults(handler=encode_document)

    args = parser.parse_args()

    if hasattr(args, "handler"):
        args.handler(args)
    else:
        parser.print_help()
