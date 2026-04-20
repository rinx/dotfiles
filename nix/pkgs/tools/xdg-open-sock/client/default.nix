{
  lib,
  pkgs,
}:
pkgs.writeShellScriptBin "xdg-open" ''
  echo -n "$1" | nc -U ~/.xdg-open.sock
''
