{
  lib,
  pkgs,
}:
pkgs.writeShellScriptBin "xdg-open" ''
  echo -n "$1" | nc -U ~/.xsr.sock
''
