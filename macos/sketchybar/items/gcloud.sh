#!/usr/bin/env sh

sketchybar \
    --add item gcloud right \
    --set gcloud script="$PLUGIN_DIR/gcloud.sh" \
    update_freq=10 \
    label.font="$FONT:Medium:12.0" \
    icon=$GCLOUD_ICON
