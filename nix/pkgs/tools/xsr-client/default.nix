{
  lib,
  pkgs,
}:
let
  pbpaste = pkgs.writeShellScriptBin "pbpaste" ''
    echo -n "{\"name\": \"paste\"}" | nc -U ~/.xsr.sock
  '';

  pngpaste = pkgs.writeShellScriptBin "pngpaste" ''
    echo -n "{\"name\": \"pngpaste\", \"arguments\": [\"-b\"]}" | nc -U ~/.xsr.sock
  '';

  xdg-open = pkgs.writeShellScriptBin "xdg-open" ''
    echo -n "{\"name\": \"open\", \"arguments\": [\"$1\"]}" | nc -U ~/.xsr.sock
  '';
in
pkgs.buildEnv {
  name = "xsr-client";
  paths = [
    pbpaste
    pngpaste
    xdg-open
  ];
}
