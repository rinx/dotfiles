#!/usr/bin/env sh

############## PRIMARY DISPLAY SPACES ############## 
SPACE_ICONS=("I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" "X")
SPACE_CLICK_SCRIPT="yabai -m space --focus \$SID 2>/dev/null"

for i in "${!SPACE_ICONS[@]}"
do
    sid=$(($i+1))
    sketchybar \
        --add space space.$sid left \
        --set space.$sid associated_space=$sid \
        icon=${SPACE_ICONS[i]} \
        icon.color=$GREY \
        icon.padding_right=10 \
        icon.highlight_color=$CREAM \
        label.drawing=off \
        click_script="$SPACE_CLICK_SCRIPT"
done
