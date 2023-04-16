#!/usr/bin/env sh

sketchybar \
    --add item github.bell right \
    --set github.bell \
    update_freq=180 \
    background.color=$CREAM \
    label.color=$BLACK \
    icon.color=$BLACK \
    icon=$GITHUB_ICON \
    icon.font="$FONT:Medium:18.0" \
    label=$LOADING \
    label.font="$FONT:Medium:12.0" \
    background.height=15 \
    background.corner_radius=4 \
    script="$PLUGIN_DIR/github_notifications.sh" \
    click_script="sketchybar --set \$NAME popup.drawing=toggle"
