#!/usr/bin/env sh

sketchybar \
    --add item net right \
    --set net script="$PLUGIN_DIR/net.sh" \
    update_freq=1 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:12.0" \
    background.height=15 \
    background.corner_radius=4 \
    label.padding_right=10
