{
  self,
  pkgs,
  flake-inputs,
}: let 
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

    custom-pkgs = [
      fennel-language-server
      google-cloud-sdk-with-components
      moralerspace-nerdfont
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
      fcp
      fd
      fzf
      gh
      ghq
      git
      gnumake
      jq
      neovim-unwrapped
      nodePackages.neovim
      open-policy-agent
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

      # k8s
      helmfile
      k3d
      k9s
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      kustomize
      stern

      # cloud development
      awscli2
      tenv

      # languages
      babashka
      buf
      clojure
      deno
      gfortran
      go
      nodejs
      typescript
      zig

      # LSP / DAP / Linter / Formatter
      buf-language-server
      clj-kondo
      clojure-lsp
      cuelsp
      delve
      docker-compose-language-service
      dockerfile-language-server-nodejs
      efm-langserver
      fennel-ls
      fortls
      gopls
      hadolint
      jq-lsp
      marksman
      nil
      nixd
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      regal
      regols
      shellcheck
      terraform-ls
      tflint
      vscode-langservers-extracted
      yaml-language-server
      zls

      # fonts
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
