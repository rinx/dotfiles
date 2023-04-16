#!/usr/bin/env sh

sketchybar \
    --add item kubectx right \
    --set kubectx script="$PLUGIN_DIR/kubectx.sh" \
    update_freq=10 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    label.font="$FONT:Medium:12.0" \
    icon.font="$FONT:Medium:12.0" \
    background.height=15 \
    background.corner_radius=4 \
    icon=$K8S_ICON
