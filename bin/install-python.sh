#!/bin/bash

set -eu

## pylsp
pip install --upgrade python-lsp-server

## optional providers
pip install --upgrade \
    rope \
    pyflakes \
    mccabe \
    pycodestyle \
    yapf \
    'python-lsp-server[rope]' \
    'python-lsp-server[pyflakes]' \
    'python-lsp-server[mccabe]' \
    'python-lsp-server[pycodestyle]' \
    'python-lsp-server[yapf]'
