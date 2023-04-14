#!/usr/bin/env sh

sketchybar \
    --add item kubectx right \
    --set kubectx script="$PLUGIN_DIR/kubectx.sh" \
    update_freq=10 \
    label.font="$FONT:Medium:12.0" \
    icon=$K8S_ICON
