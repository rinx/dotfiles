#!/usr/bin/env sh

sketchybar \
    --add slider volume right \
    --set volume script="$PLUGIN_DIR/volume.sh" \
    update_freq=3 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:12.0" \
    background.height=15 \
    background.corner_radius=4 \
    --subscribe volume volume_change
