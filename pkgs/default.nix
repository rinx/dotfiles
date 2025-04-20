{
  self,
  pkgs,
  system,
  ...
}@inputs:
let
  falco = pkgs.callPackage ./tools/falco {
    ysugimoto-falco = inputs.ysugimoto-falco;
  };

  gh-actions-language-server = pkgs.callPackage ./tools/gh-actions-ls {
    inherit pkgs;
  };

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

  moralerspace-nerdfont = pkgs.callPackage ./fonts/moralerspace-nerdfont { };

  rq = pkgs.callPackage ./tools/rq {
    charles-rq = inputs.charles-rq;
  };

  mcp-servers = pkgs.callPackage ./settings/mcp-servers {
    mcp-servers-nix = inputs.mcp-servers-nix;
  };

  custom-pkgs = [
    falco
    gh-actions-language-server
    google-cloud-sdk-with-components
    inputs.mcp-hub.packages."${system}".default
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
      direnv
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
