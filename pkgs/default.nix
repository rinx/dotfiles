{
  self,
  pkgs,
  mcp-hub,
  mcp-servers-nix,
  flake-inputs,
  system,
}:
let
  falco = pkgs.callPackage ./falco.nix { };

  gh-actions-language-server = pkgs.callPackage ./gh-actions-ls.nix {
    inherit pkgs;
  };

  google-cloud-sdk-with-components = pkgs.google-cloud-sdk.withExtraComponents [
    pkgs.google-cloud-sdk.components.beta
    pkgs.google-cloud-sdk.components.bq
    pkgs.google-cloud-sdk.components.core
    pkgs.google-cloud-sdk.components.gcloud-crc32c
    pkgs.google-cloud-sdk.components.gsutil
    pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
  ];

  moralerspace-nerdfont = pkgs.callPackage ./moralerspace-nerdfont.nix { };

  rq = pkgs.callPackage ./rq.nix { };

  mcp-servers = pkgs.callPackage ./mcp-servers.nix {
    inherit pkgs;
    inherit mcp-servers-nix;
  };

  custom-pkgs = [
    falco
    gh-actions-language-server
    google-cloud-sdk-with-components
    mcp-hub.packages."${system}".default
    mcp-servers
    moralerspace-nerdfont
    rq
  ];
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
      docker-credential-helpers
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
      beamMinimalPackages.erlang
      beamMinimalPackages.rebar3
      buf
      clojure
      deno
      gleam
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
      regal
      shellcheck
      shfmt
      terraform-ls
      tflint
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server

      ## fonts
      hackgen-nf-font
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
      nerd-fonts.victor-mono
    ]
    ++ custom-pkgs;
}
