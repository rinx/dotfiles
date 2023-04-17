#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

PRS="$(gh search prs --state=open --review-requested=@me --json=repository,url,title)"
COUNT="$(echo "$PRS" | jq 'length')"
args=()
if [ "$PRS" = "[]" ]; then
  args+=(--set $NAME icon="$PULLREQ_ICON" label="0")
else
  args+=(--set $NAME icon="$PULLREQ_ICON" label="$COUNT")
fi

args+=(--remove '/github.prlist\.*/')

COUNT=0
COLOR=$BLACK
args+=(--set github.pr icon.color=$COLOR)

while read -r repo url title 
do
  COUNT=$((COUNT + 1))
  COLOR=0xff9dd274
  PADDING=0
  ICON="$PULLREQ_ICON"
  
  args+=(--add item github.prlist.$COUNT popup.github.pr                                      \
         --set github.prlist.$COUNT background.padding_left=7                                   \
                                    background.padding_right=7                                  \
                                    background.color=0x22e1e3e4                                 \
                                    background.drawing=off                                      \
                                    icon.background.height=1                                    \
                                    icon.background.y_offset=-12                                \
                                    icon.background.color=$COLOR                                \
                                    icon.padding_left="$PADDING"                                \
                                    icon.color=$COLOR                                           \
                                    icon.background.shadow.color=0xff2a2f38                     \
                                    icon.background.shadow.angle=25                             \
                                    icon.background.shadow.distance=2                           \
                                    icon.background.shadow.drawing=on                           \
                                    icon="$ICON $(echo "$repo" | sed -e "s/^'//" -e "s/'$//"):" \
                                    label="$(echo "$title" | sed -e "s/^'//" -e "s/'$//")"      \
                                    script='case "$SENDER" in
                                              "mouse.entered") sketchybar --set $NAME background.drawing=on
                                              ;;
                                              "mouse.exited") sketchybar --set $NAME background.drawing=off
                                              ;;
                                            esac' \
                                    click_script="open ${url};
                                                  sketchybar --set github.pr popup.drawing=off"
        --subscribe github.prlist.$COUNT mouse.entered mouse.exited)
done <<< "$(echo "$PRS" | jq -r '.[] | [.repository.name, .url, .title] | @sh')"

sketchybar -m "${args[@]}" 
