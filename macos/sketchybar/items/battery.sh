#!/usr/bin/env sh

sketchybar \
    --add item battery right \
    --set battery script="$PLUGIN_DIR/battery.sh" \
    update_freq=5 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:14.0" \
    background.height=15 \
    background.corner_radius=4 \
    --subscribe battery system_woke
