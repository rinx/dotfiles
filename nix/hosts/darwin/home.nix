{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    inputs.agent-skills.homeManagerModules.default
  ];

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
      # brew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      export GOPATH="''${HOME}/local"

      # secretive
      export SSH_AUTH_SOCK="''${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    '';
  };

  home.packages = [
  ]
  ++ inputs.additional-packages;

  home.stateVersion = "25.11";
}
