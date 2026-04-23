{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    ../common/home.nix
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };

  home.username = "nix-on-droid";
  home.homeDirectory = "/data/data/com.termux.nix/files/home";

  home.file = {
    ".zshenv".text = ''
      export NVIM_DISABLE_TS_PARSER_INSTALL=1

      export GPG_TTY=''$(tty)

      export GOPATH="''${HOME}/local"

      eval "''$(direnv hook zsh)"
    '';
  };

  home.stateVersion = "24.05";
}
