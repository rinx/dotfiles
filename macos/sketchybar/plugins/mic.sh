#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

update() {
  MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')
  if [[ $MIC_VOLUME -eq 0 ]]; then
    sketchybar --set $NAME icon=$MIC_MUTE label="MUTE"
  elif [[ $MIC_VOLUME -gt 0 ]]; then
    sketchybar --set $NAME icon=$MIC label="$MIC_VOLUME%"
  fi 
}

click() {
  MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')
  if [[ $MIC_VOLUME -eq 0 ]]; then
    osascript -e 'set volume input volume 60'
  elif [[ $MIC_VOLUME -gt 0 ]]; then
    osascript -e 'set volume input volume 0'
  fi

  update
}

case "$SENDER" in
  "mouse.clicked") click
  ;;
  *) update
  ;;
esac
