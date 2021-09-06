#!/bin/bash

set -eu

## ghcup
export BOOTSTRAP_HASKELL_NONINTERACTIVE=1
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

## hls
source $HOME/.ghcup/env
ghcup install hls

echo "please run 'source $HOME/.ghcup/env' in your session"
