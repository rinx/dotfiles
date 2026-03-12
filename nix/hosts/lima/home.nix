{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  home.username = "rinx";
  home.homeDirectory = lib.mkForce "/home/${config.home.username}.linux";

  home.file = {
    # Zsh
    ".zshenv".text = ''
      export GOPATH="''${HOME}/local"
    '';

    # GPG
    ".gnupg/gpg.conf".text = ''
      no-autostart
    '';
  };

  home.packages = [
  ]
  ++ inputs.additional-packages;

  home.stateVersion = "25.11";
}
