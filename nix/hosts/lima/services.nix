{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };

  services.gpg-agent = {
    enable = false;
  };
}
