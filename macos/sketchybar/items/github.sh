#!/usr/bin/env sh

sketchybar \
    --add item github.bell right \
    --set github.bell \
    update_freq=180 \
    icon=$GITHUB_ICON \
    icon.font="$FONT:Medium:18.0" \
    label=$LOADING \
    script="$PLUGIN_DIR/github_notifications.sh" \
    click_script="sketchybar --set \$NAME popup.drawing=toggle"
