#!/usr/bin/env sh

############## PRIMARY DISPLAY SPACES ############## 
SPACE_ICONS=(" " " " " " " " " " " " " " " " " " " ")
# SPACE_ICONS=(" " " " " " " " " " " " " " " " " " " ")
# SPACE_ICONS=(" " " " " " " " " " " " " " " " " " " ")

for i in "${!SPACE_ICONS[@]}"
do
    sid=$(($i+1))
    sketchybar \
        --add space space.$sid left \
        --set space.$sid associated_space=$sid \
        icon=${SPACE_ICONS[i]} \
        icon.color=$GREY \
        icon.padding_right=4 \
        icon.highlight_color=$CREAM \
        label.font="$FONT:Regular:16.0" \
        icon.font="$FONT:Regular:16.0" \
        background.height=18 \
        background.corner_radius=4 \
        script="$PLUGIN_DIR/spaces.sh" \
        --subscribe space.$sid front_app_switched
done
