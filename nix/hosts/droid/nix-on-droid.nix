{
  config,
  lib,
  pkgs,
  ...
}:
{
  android-integration.termux-open.enable = true;
  android-integration.termux-open-url.enable = true;
  android-integration.termux-reload-settings.enable = true;
  android-integration.termux-setup-storage.enable = true;

  environment.packages = with pkgs; [
    babashka
    bat
    curl
    delta
    deno
    direnv
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
    nix-direnv
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

    moralerspace-hw
    hackgen-nf-font

    procps
    killall
    diffutils
    findutils
    utillinux
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
  ];

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  terminal.font = "${pkgs.moralerspace-hw}/share/fonts/moralerspace-hw/MoralerspaceNeonHW-Regular.ttf";

  time.timeZone = "Asia/Tokyo";

  user.shell = "${pkgs.zsh}/bin/zsh";
}
