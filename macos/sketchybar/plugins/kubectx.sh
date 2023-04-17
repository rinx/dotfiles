#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

CONTEXTS=$(kubectl config get-contexts -o=name | sort -n)
CURRENT_CONTEXT=$(kubectl config current-context | cut -d'_' -f2,4)

args=()
args+=(--set $NAME label="$CURRENT_CONTEXT")

args+=(--remove '/kubectx.list\.*/')

COUNT=0
ICON="$K8S_ICON"
COLOR=0xff9dd274

for ctx in $CONTEXTS
do
  COUNT=$((COUNT + 1))
  PADDING=0

  shortctx=$(echo "$ctx" | cut -d'_' -f2,4)

  args+=(--add item kubectx.list.$COUNT popup.kubectx.current \
         --set kubectx.list.$COUNT background.padding_left=7                                   \
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
                                   icon="$ICON" \
                                   label="$ctx" \
                                   script='case "$SENDER" in
                                             "mouse.entered") sketchybar --set $NAME background.drawing=on
                                             ;;
                                             "mouse.exited") sketchybar --set $NAME background.drawing=off
                                             ;;
                                           esac' \
                                   click_script="kubectl config use-context $ctx;
                                                 sketchybar --set kubectx.current label=$shortctx
                                                 sketchybar --set kubectx.current popup.drawing=off"
        --subscribe kubectx.list.$COUNT mouse.entered mouse.exited)

done

sketchybar -m "${args[@]}" 
