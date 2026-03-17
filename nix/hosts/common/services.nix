{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };

  programs.home-manager.enable = true;
}
