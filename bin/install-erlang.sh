#!/bin/bash

set -eu

## erlang
apt update
apt install -y erlang

## rebar3
curl -o /usr/local/bin/rebar3 https://s3.amazonaws.com/rebar3/rebar3
chmod +x /usr/local/bin/rebar3

git clone https://github.com/erlang-ls/erlang_ls.git /tmp/erlang_ls
cd /tmp/erlang_ls
make
make install
