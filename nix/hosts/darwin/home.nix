{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  home.username = inputs.username;
  home.homeDirectory = lib.mkForce "/Users/${config.home.username}";

  home.file = {
    ".aerospace.toml".source = ../../../macos/aerospace.toml;
    ".config/kitty/kitty.conf".source = ../../../kitty.conf;
    ".config/sketchybar" = {
      source = ../../../macos/sketchybar;
      recursive = true;
    };

    # Zsh
    ".zshenv".text = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export GOPATH="''${HOME}/local"
    '';
  };

  home.packages = [
  ]
  ++ inputs.additional-packages;

  home.stateVersion = "25.11";
}
