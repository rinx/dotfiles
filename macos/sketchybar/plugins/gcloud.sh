#!/usr/bin/env sh

sketchybar -m --set $NAME label="$(/usr/local/bin/gcloud config list --format 'value(core.project)')"
