#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

ics() {
  case $@ in
    "Google Chrome")
      result=""
      ;;
    "kitty")
      result="󰆍"
      ;;
    "Finder")
      result="󰀶"
      ;;
    "Microsoft Teams")
      result="󰊻"
      ;;
    "goneovim")
      result=""
      ;;
    # "")
    #   result=""
    #   ;;
    *)
      result=""
      ;;
  esac
  echo $result
}

if [[ $SELECTED == true ]]; then
    sketchybar --set $NAME icon.color=$BLACK \
                           label.color=$BLACK \
                           background.color=$CREAM \
                           background.border_color=$CREAM \
                           background.padding_left=3 \
                           background.padding_right=3
else
    sketchybar --set $NAME icon.color=$BLACK \
                           label.color=$BLACK \
                           background.color=$GREY \
                           background.border_color=$GREY \
                           background.padding_left=3 \
                           background.padding_right=3
fi

SPACES=(" " " " " " " " " " " " " " " " " " " ")

if [[ $SENDER == "front_app_switched" ]]; then

    for i in "${!SPACES[@]}"; do
        sid=$(($i+1))
        arr=()
        icons=""

        QUERY=$(yabai -m query --windows --space $sid | jq '.[].app')

        if grep -q "\"" <<< $QUERY; then

          IFS=$'\n'
          for e in $(echo "$QUERY")
          do
            icon=$(echo $e | sed 's/"//g')
            icon=$(ics $icon)
            icons+="$icon "
          done

        fi

        sketchybar --set space.$sid label="$icons"
    done
fi
