#!/usr/bin/env sh

sketchybar \
    --add item mic right \
    --set mic script="$PLUGIN_DIR/mic.sh" \
    update_freq=3 \
    label.font="$FONT:Regular:12.0" \
    label.padding_right=8 \
    --subscribe mic mouse.clicked
