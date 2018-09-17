#!/bin/bash

list=(
    $(swaymsg -t get_tree |
        jq -rM '.nodes[].nodes[] | {workspace: (.name), window: .nodes[].name} | .workspace, .window' |
        sed -e 's: :%%%SPACE%%%:g')
    )

for (( i=1; i<=$((${#list[@]}/2)); i++ )); do
  [[ -z "$@" ]] && echo "[${list[$i*2-2]}] $(echo ${list[$i*2-1]} | sed -e 's:%%%SPACE%%%: :g')" && continue
  [[ "$@" == "[${list[$i*2-2]}] $(echo ${list[$i*2-1]} | sed -e 's:%%%SPACE%%%: :g')" ]] && \
      command="swaymsg workspace ${list[$i*2-2]} > /dev/null 2>&1" && break
done
eval "${command:-:}"
