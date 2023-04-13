#!/usr/bin/env sh

sketchybar \
    --add item gcloud right \
    --set gcloud script="$PLUGIN_DIR/gcloud.sh" \
    update_freq=10 \
    icon=$GCLOUD_ICON
