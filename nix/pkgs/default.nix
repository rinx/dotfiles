{
  self,
  pkgs,
  flake-inputs,
}: let 
    jq-lsp = pkgs.callPackage ./jq-lsp.nix {};
    regols = pkgs.callPackage ./regols.nix {};

    custom-pkgs = [
      jq-lsp
      regols
    ];
  in pkgs.buildEnv {
    name = "basic-packages";

    paths = with pkgs; [

      # tools
      bat
      cmakeMinimal
      curl
      delta
      docker-credential-helpers
      eza
      fd
      fzf
      fzy
      gh
      ghq
      git
      gnumake
      jq
      neovim-unwrapped
      open-policy-agent
      pass
      ripgrep
      sad
      tmux
      tmux-xpanes
      wget
      yq
      zsh

      # k8s
      helmfile
      k3d
      k9s
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      stern

      # cloud development
      awscli2
      google-cloud-sdk
      terraform

      # languages
      babashka
      buf
      clojure
      deno
      gfortran
      go
      nodejs
      nodePackages.typescript

      # LSP / DAP / Linter / Formatter
      buf-language-server
      clojure-lsp
      cuelsp
      delve
      efm-langserver
      # fennel-language-server
      fortls
      gopls
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      # regal
      terraform-ls
      tflint

      # fonts
      hackgen-nf-font
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "VictorMono"
        ];
      })
    ] ++ custom-pkgs;
  }
