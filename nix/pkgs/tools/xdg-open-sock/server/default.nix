{
  pkgs,
}:
pkgs.buildGleamApplication {
  pname = "xdg-open-sock";
  version = "0.1.0";

  src = pkgs.lib.cleanSource ./.;

  gleamNix = import ./gleam.nix;
}
