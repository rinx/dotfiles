{
  self,
  pkgs,
  flake-inputs,
}: let 
    falco = pkgs.callPackage ./falco.nix {};

    fennel-language-server = pkgs.callPackage ./fennel-language-server.nix {};

    google-cloud-sdk-with-components = pkgs.google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.beta
      pkgs.google-cloud-sdk.components.bq
      pkgs.google-cloud-sdk.components.core
      pkgs.google-cloud-sdk.components.gcloud-crc32c
      pkgs.google-cloud-sdk.components.gsutil
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ];

    moralerspace-nerdfont = pkgs.callPackage ./moralerspace-nerdfont.nix {};

    rq = pkgs.callPackage ./rq.nix {};

    custom-pkgs = [
      falco
      fennel-language-server
      google-cloud-sdk-with-components
      moralerspace-nerdfont
      rq
    ];
  in pkgs.buildEnv {
    name = "basic-packages";

    paths = with pkgs; [

      ## tools
      ast-grep
      bat
      cmakeMinimal
      conftest
      cosign
      cue
      curl
      delta
      docker-credential-helpers
      eza
      fd
      fzf
      gh
      ghq
      git
      gitsign
      gnumake
      jq
      lazygit
      neovim-unwrapped
      open-policy-agent
      pandoc
      pass
      passExtensions.pass-otp
      ripgrep
      sad
      tmux
      tmux-xpanes
      tree-sitter
      wget
      yq-go
      zellij
      zsh

      ## k8s
      k3d
      k9s
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      stern

      ## cloud development
      awscli2
      tenv

      ## languages
      babashka
      buf
      clojure
      deno
      gfortran
      go
      nodejs
      protobuf
      typescript

      ## LSP / DAP / Linter / Formatter
      actionlint
      bash-language-server
      clj-kondo
      clojure-lsp
      cuelsp
      delve
      docker-compose-language-service
      dockerfile-language-server-nodejs
      efm-langserver
      fennel-ls
      fortls
      gitlint
      gopls
      hadolint
      harper
      jq-lsp
      marksman
      nil
      nixd
      nodePackages.typescript-language-server
      regal
      shellcheck
      shfmt
      terraform-ls
      tflint
      vscode-langservers-extracted
      yaml-language-server

      ## fonts
      hackgen-nf-font
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
          "Monaspace"
          "VictorMono"
        ];
      })
    ] ++ custom-pkgs;
  }
