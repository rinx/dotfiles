#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

update() {
  MUTED=$(osascript -e 'output muted of (get volume settings)')
  if [[ "$MUTED" = "true" ]]; then
    sketchybar --set $NAME icon=$VOLUME_MUTE_ICON label="MUTE"
  else
    VOLUME=$(osascript -e 'output volume of (get volume settings)')
    sketchybar --set $NAME icon=$VOLUME_ICON label="$VOLUME%"
  fi
}

click() {
  MUTED=$(osascript -e 'output muted of (get volume settings)')
  if [[ "$MUTED" = "true" ]]; then
    osascript -e 'set volume without output muted'
  else
    osascript -e 'set volume with output muted'
  fi

  update
}

case "$SENDER" in
  "mouse.clicked") click
  ;;
  *) update
  ;;
esac
