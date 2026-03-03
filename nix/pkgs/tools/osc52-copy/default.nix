{
  lib,
  pkgs,
}:
pkgs.writeShellScriptBin "pbcopy" ''
  if [[ $# == 0 ]]; then
    payload=$(cat -)
  else
    payload=$(echo -n "$1")
  fi
  b64_payload=$(printf "%s" "$payload" | base64 -w0)

  printf "\e]52;c;%s\a" "$b64_payload"
''
