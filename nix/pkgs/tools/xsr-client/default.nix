{
  lib,
  pkgs,
}:
let
  pbpaste = pkgs.writeShellScriptBin "pbpaste" ''
    echo -n "{\"name\": \"paste\"}" | nc -U ~/.xsr.sock
  '';

  xdg-open = pkgs.writeShellScriptBin "xdg-open" ''
    echo -n "{\"name\": \"open\", \"argument\": \"$1\"}" | nc -U ~/.xsr.sock
  '';
in
pkgs.buildEnv {
  name = "xsr-client";
  paths = [
    pbpaste
    xdg-open
  ];
}
