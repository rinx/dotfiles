#!/bin/bash

set -eu

## texlive
apt update
apt install -y \
    texlive-lang-japanese \
    texlive-luatex \
    texlive-xetex \
    xzdec
tlmgr init-usertree

## texlab
cd /tmp
curl -sL https://github.com/latex-lsp/texlab/releases/latest/download/texlab-x86_64-linux.tar.gz -o texlab.tar.gz
tar xzf texlab.tar.gz
mv texlab /usr/local/bin/texlab
rm -rf texlab.tar.gz
