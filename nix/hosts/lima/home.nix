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

    # Git
    ".gitconfig".source = ../../../gitconfig;
    ".gitignore".source = ../../../gitignore;
    ".gitattributes_global".source = ../../../gitattributes_global;
    ".commit_template".source = ../../../.commit_template;

    # Zsh
    ".zshrc".source = ../../../zshrc;
    ".p10k.zsh".source = ../../../p10k.zsh;
  };

  home.packages = [
  ]
  ++ inputs.additional-packages;

  home.stateVersion = "25.11";

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    nix-direnv.enable = true;
  };
}
