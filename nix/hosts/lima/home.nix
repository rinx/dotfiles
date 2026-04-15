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
  home.homeDirectory = lib.mkForce "/home/${config.home.username}.guest";

  home.file = {
    # Zsh
    ".zshenv".text = ''
      export GOPATH="''${HOME}/local"

      echo "%Assuan%\nsocket=''${HOME}/.S.gpg-agent.host" > $(gpgconf --list-dir agent-socket)
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
