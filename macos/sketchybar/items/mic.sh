#!/usr/bin/env sh

sketchybar \
    --add item mic right \
    --set mic script="$PLUGIN_DIR/mic.sh" \
    update_freq=3 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:12.0" \
    background.height=15 \
    background.corner_radius=4 \
    --subscribe mic mouse.clicked
