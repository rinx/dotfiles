{
  lib,
  pkgs,
}:
pkgs.writeShellScriptBin "xdg-open" ''
  echo -n "{\"name\": \"open\", \"argument\": \"$1\"}" | nc -U ~/.xsr.sock
''
