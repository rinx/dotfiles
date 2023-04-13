#!/usr/bin/env sh

sketchybar \
    --add item kubectx right \
    --set kubectx script="$PLUGIN_DIR/kubectx.sh" \
    update_freq=10 \
    icon=$K8S_ICON
