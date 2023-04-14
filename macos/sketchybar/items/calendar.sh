#!/usr/bin/env sh

sketchybar \
    --add item time right \
    --set time update_freq=2 \
    icon.padding_right=0 \
    label.padding_left=0 \
    label.color=$CREAM \
    label.font="$FONT:Medium:12.0" \
    script="$PLUGIN_DIR/time.sh" \
    \
    --add item date right \
    --set date update_freq=60 \
    background.color=$CREAM \
    label.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.padding_right=0 \
    label.padding_left=0 \
    background.height=15 \
    background.corner_radius=4 \
    script="$PLUGIN_DIR/date.sh"
