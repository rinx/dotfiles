{
  self,
  pkgs,
  system,
  ...
}@inputs:
let
  aws-sts-token = pkgs.callPackage ./tools/aws-sts-token { };

  falco = pkgs.callPackage ./tools/falco {
    source = inputs.ysugimoto-falco;
  };

  fennel-ls = pkgs.callPackage ./tools/fennel-ls {
    source = inputs.fennel-ls;
  };

  gctx = pkgs.callPackage ./tools/gctx { };

  gh-actions-language-server = pkgs.callPackage ./tools/gh-actions-ls {
    inherit pkgs;
  };

  git-switcher = pkgs.callPackage ./tools/git-switcher { };

  google-cloud-sdk-with-components =
    with pkgs.google-cloud-sdk;
    withExtraComponents (
      with components;
      [
        beta
        bq
        core
        gcloud-crc32c
        gsutil
        gke-gcloud-auth-plugin
      ]
    );

  org-search-utils = pkgs.callPackage ./tools/org-search-utils { };

  rq = pkgs.callPackage ./tools/rq {
    source = inputs.charles-rq;
  };

  mcp-servers = pkgs.callPackage ./settings/mcp-servers {
    mcp-servers-nix = inputs.mcp-servers-nix;
  };

  custom-pkgs = [
    aws-sts-token
    falco
    fennel-ls
    gctx
    gh-actions-language-server
    git-switcher
    google-cloud-sdk-with-components
    inputs.mcp-hub.packages."${system}".default
    mcp-servers
    org-search-utils
    rq
  ];

  darwin-pkgs =
    if pkgs.stdenv.isDarwin then
      [
        pkgs.pngpaste
      ]
    else
      [ ];
in
pkgs.buildEnv {
  name = "basic-packages";

  paths =
    with pkgs;
    [

      ## tools
      ast-grep
      bat
      cmakeMinimal
      conftest
      cosign
      cue
      curl
      delta
      direnv
      docker-credential-helpers
      duckdb
      eza
      fd
      fzf
      gh
      ghq
      git
      gitsign
      gnumake
      imagemagick
      jq
      lazygit
      neovim-unwrapped
      nix-direnv
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
      gleam
      go
      nodejs
      protobuf
      typescript-go
      typst

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
      gitlint
      gopls
      hadolint
      marksman
      nil
      nixd
      regal
      shellcheck
      shfmt
      terraform-ls
      tflint
      tinymist
      vscode-langservers-extracted
      yaml-language-server

      ## fonts
      moralerspace-nf
      moralerspace-hwnf
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
    ]
    ++ custom-pkgs
    ++ darwin-pkgs;
}
