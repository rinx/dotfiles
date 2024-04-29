{
  self,
  pkgs,
  flake-inputs,
}: let 
    fennel-language-server = pkgs.callPackage ./fennel-language-server.nix {};

    google-cloud-sdk-with-components = pkgs.google-cloud-sdk.withExtraComponents ([
      pkgs.google-cloud-sdk.components.beta
      pkgs.google-cloud-sdk.components.bq
      pkgs.google-cloud-sdk.components.core
      pkgs.google-cloud-sdk.components.gcloud-crc32c
      pkgs.google-cloud-sdk.components.gsutil
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ]);

    custom-pkgs = [
      fennel-language-server
      google-cloud-sdk-with-components
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
      nodePackages.neovim
      open-policy-agent
      pass
      ripgrep
      sad
      tmux
      tmux-xpanes
      tree-sitter
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
      zig

      # LSP / DAP / Linter / Formatter
      buf-language-server
      clojure-lsp
      cuelsp
      delve
      efm-langserver
      fennel-ls
      fortls
      gopls
      jq-lsp
      marksman
      nil
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      regal
      regols
      terraform-ls
      tflint
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
