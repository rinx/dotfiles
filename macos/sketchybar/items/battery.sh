#!/usr/bin/env sh

sketchybar \
    --add item battery right \
    --set battery script="$PLUGIN_DIR/battery.sh" \
    update_freq=5 \
    label.font="$FONT:Regular:12.0" \
    icon.font="$FONT:Medium:14.0" \
    label.color=$WHITE \
    icon.color=$WHITE \
    label.padding_right=8 \
    --subscribe battery system_woke
