{
  config,
  lib,
  pkgs,
  ...
}@inputs:
{
  home.file = {
    # Neovim
    ".config/nvim/init.lua".source = ../../../nvim/init.lua;
    ".config/nvim/lua" = {
      source = ../../../nvim/lua;
      recursive = true;
    };
    ".config/nvim/snippets" = {
      source = ../../../nvim/snippets;
      recursive = true;
    };
    ".config/nvim/orgmode" = {
      source = ../../../nvim/orgmode;
      recursive = true;
    };
    ".config/nvim/lazy-lock.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/local/src/github.com/rinx/dotfiles/nvim/lazy-lock.json";

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
    ".config/zsh/rc" = {
      source = ../../../zshrc.d;
      recursive = true;
    };
    ".p10k.zsh".source = ../../../p10k.zsh;
  };
}
