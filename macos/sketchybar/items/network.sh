#!/usr/bin/env sh

sketchybar \
    --add item network right \
    --set network label.font="$FONT:Medium:12.0" \
    update_freq=1 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:14.0" \
    background.height=15 \
    background.corner_radius=4 \
    script="$PLUGIN_DIR/network.sh"
