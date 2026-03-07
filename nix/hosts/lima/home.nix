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
    ".dotfiles".source = ../../..;

    # Neovim
    ".config/nvim/init.lua".source = ../../../nvim/init.lua;
    ".config/nvim/lua".source = ../../../nvim/lua;
    ".config/nvim/snippets".source = ../../../nvim/snippets;
    ".config/nvim/lazy-lock.json".source = ../../../nvim/lazy-lock.json;

    ".SKK-JISYO.L".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/skk-users-jp/dic-mirror/gh-pages/SKK-JISYO.L";
      sha256 = "2a26bf823943768056d3f128e9ec40549d0a3d46df5d99b76752a99a4d55a286";
    };

    # Git
    ".gitconfig".source = ../../../gitconfig;
    ".gitignore".source = ../../../gitignore;
    ".gitattributes_global".source = ../../../gitattributes_global;
    ".commit_template".source = ../../../.commit_template;

    # Zsh
    ".zshrc".source = ../../../zshrc;
    ".p10k.zsh".source = ../../../p10k.zsh;
    ".zshenv".text = ''
      export GOPATH="''${HOME}/local"
    '';
  };

  home.packages = [
  ]
  ++ inputs.additional-packages;

  home.stateVersion = "25.11";
}
