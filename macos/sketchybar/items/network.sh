#!/usr/bin/env sh

sketchybar \
    --add item network right \
    --set network label.font="$FONT:Medium:12.0" \
    label.padding_right=4 \
    icon.font="$FONT:Medium:18.0" \
    label.padding_right=4 \
    update_freq=1 \
    script="$PLUGIN_DIR/network.sh"
