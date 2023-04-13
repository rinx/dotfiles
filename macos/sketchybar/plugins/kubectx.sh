#!/usr/bin/env sh

sketchybar -m --set $NAME label="$(/usr/local/bin/kubectl config current-context | cut -d'_' -f2,4)"
