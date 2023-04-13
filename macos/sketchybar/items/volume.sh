#!/usr/bin/env sh

sketchybar \
    --add slider volume right \
    --set volume script="$PLUGIN_DIR/volume.sh" \
    update_freq=3 \
    label.font="$FONT:Regular:12.0" \
    label.padding_right=8 \
    --subscribe volume volume_change
