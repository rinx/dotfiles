{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  additional-packages,
  ...
}:
{
  android-integration.termux-open.enable = true;
  android-integration.termux-open-url.enable = true;
  android-integration.termux-reload-settings.enable = true;
  android-integration.termux-setup-storage.enable = true;

  environment.packages =
    with pkgs-unstable;
    [
      babashka
      bat
      curl
      delta
      deno
      eza
      fd
      fzf
      gcc
      gh
      ghq
      git
      gnumake
      jq
      neovim-unwrapped
      nodejs
      ripgrep
      tree-sitter
      vim
      yq-go
      zsh

      openssh
      pinentry-curses
      which

      nil
      nixd

      maple-mono.NF-CN

      claude-code
      ollama

      procps
      killall
      diffutils
      findutils
      util-linux
      tzdata
      hostname
      gnugrep
      gnupg
      gnused
      gnutar
      bzip2
      gzip
      xz
      zip
      unzip
    ]
    ++ additional-packages;

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  terminal.font = "${pkgs-unstable.maple-mono.NF-CN}/share/fonts/truetype/MapleMono-NF-CN-Regular.ttf";

  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs-unstable.zsh}/bin/zsh";

  home-manager = {
    useGlobalPkgs = false;
    useUserPackages = true;
    config = ./home.nix;
  };
}
